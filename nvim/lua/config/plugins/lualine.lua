return {
	"nvim-lualine/lualine.nvim",
	lazy = false,

	config = function()
		local lualine = require("lualine")
		local colorscheme = require("config.ui").colorscheme.value
		local colors = require("nightfox.palette").load(colorscheme)
		local window_width_limit = 100
		local branch_icon = "󰘬 "
		local plugin_checker = require("lazy.manage.checker")
		local gstatus = { ahead = 0, behind = 0 }
		local List = require("plenary.collections.py_list")
		local diagnostic_signs = require("kind").diagnostic_signs
		local diff_signs = require("kind").diff_icons

		local disabled_filetypes = List({
			"TelescopePrompt",
			"lazy",
			"oil",
			"lazygit",
			"Trouble",
			"lspinfo",
			"mason",
		})

		local lsp_kind = {
			tsserver = "TSServer",
			eslint = "ESLint",
			angularls = "Angular LS",
			cssls = "CSS LS",
			emmet_ls = "Emmet",
			html = "HTML",
			jsonls = "JSON",
			lua_ls = "Lua LS",
			marksman = "Marksman",
			stylelint_lsp = "Stylelint",
			svelte = "Svelte",
			bashls = "Bash",
		}

		local function update_gstatus()
			local Job = require("plenary.job")
			Job:new({
				command = "git",
				args = { "rev-list", "--left-right", "--count", "HEAD...@{upstream}" },
				on_exit = function(job, _)
					local res = job:result()[1]
					if type(res) ~= "string" then
						gstatus = { ahead = 0, behind = 0 }
						return
					end
					local ok, ahead, behind = pcall(string.match, res, "(%d+)%s*(%d+)")
					if not ok then
						ahead, behind = 0, 0
					end
					gstatus = { ahead = ahead, behind = behind }
				end,
			}):start()
		end

		local function show_macro_recording()
			local base = ""
			local recording_register = vim.fn.reg_recording()
			if recording_register == base then
				return base
			else
				return "Recording @" .. recording_register
			end
		end

		if _G.Gstatus_timer == nil then
			_G.Gstatus_timer = vim.loop.new_timer()
		else
			_G.Gstatus_timer:stop()
		end
		_G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(update_gstatus))

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.o.columns > window_width_limit
			end,
			hide_in_disabled_ft = function()
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				return not disabled_filetypes:contains(buf_ft)
			end,
		}

		local function diff_source()
			local gitsigns = vim.b.gitsigns_status_dict
			if gitsigns then
				return {
					added = gitsigns.added,
					modified = gitsigns.changed,
					removed = gitsigns.removed,
				}
			end
		end

		local mode = {
			"mode",
			color = {
				bg = colors.bg3,
				fg = colors.orange.base,
			},
			separator = { right = "", left = "" },
		}

		local branch = {
			"b:gitsigns_head",
			icon = branch_icon,
			color = {
				bg = colors.bg3,
				fg = colors.magenta.bright,
			},
			separator = { right = "", left = "" },
		}

		local status = {
			function()
				return " " .. gstatus.behind .. "  " .. gstatus.ahead
			end,
			cond = function()
				local gitsigns = vim.b.gitsigns_status_dict
				local shouldShow = gitsigns and (tonumber(gstatus.behind) > 0 or tonumber(gstatus.ahead) > 0)
				return shouldShow
			end,
			padding = { left = 0, right = 1 },
			separator = { right = "", left = "" },
			color = {
				bg = colors.bg2,
				fg = colors.magenta.bright,
			},
		}

		local diff = {
			"diff",
			source = diff_source,
			symbols = {
				added = diff_signs.added,
				modified = diff_signs.modified,
				removed = diff_signs.removed,
			},
			padding = { left = 2, right = 1 },
			diff_color = {
				added = { fg = colors.green.base },
				modified = { fg = colors.yellow.base },
				removed = { fg = colors.red.base },
			},
			cond = nil,
		}

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = {
				error = diagnostic_signs.error .. " ",
				warn = diagnostic_signs.warn .. " ",
				info = diagnostic_signs.info .. " ",
				hint = diagnostic_signs.hint .. " ",
			},
		}

		local treesitter = {
			function()
				return " "
			end,
			padding = { left = 1, right = 1 },
			color = function()
				local buf = vim.api.nvim_get_current_buf()
				local ts = vim.treesitter.highlighter.active[buf]
				return { fg = ts and not vim.tbl_isempty(ts) and colors.green.base or colors.red.base }
			end,
			cond = conditions.hide_in_disabled_ft,
		}

		local location = {
			"location",
			color = {
				fg = colors.fg3,
			},
		}

		local progress = {
			"progress",
			fmt = function()
				return "%P/%L"
			end,
			color = {},
		}

		local spaces = {
			function()
				local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
				return "Spaces: " .. shiftwidth
			end,
			color = {
				fg = colors.fg3,
			},
		}

		local encoding = {
			"o:encoding",
			fmt = string.upper,
			color = {
				fg = colors.fg3,
			},
			cond = conditions.hide_in_width,
		}

		-- local filetype = {
		-- 	"filetype",
		-- 	icon_only = true,
		-- 	separator = { right = "", left = "" },
		-- 	color = {
		-- 		fg = colors.magenta.bright,
		-- 		bg = colors.bg2,
		-- 	},
		-- 	padding = { left = 1, right = 0 },
		-- 	cond = conditions.hide_in_disabled_ft,
		-- }
		--
		-- local filename = {
		-- 	"filename",
		-- 	padding = { left = 2, right = 0 },
		-- 	file_status = true, -- displays file status (readonly status, modified status)
		-- 	newfile_status = false,
		-- 	path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
		-- 	symbols = {
		-- 		modified = "○",
		-- 		readonly = "",
		-- 		unnamed = "",
		-- 	},
		-- 	color = {
		-- 		fg = colors.magenta.bright,
		-- 		bg = colors.bg2,
		-- 	},
		-- 	separator = { right = "", left = "" },
		-- 	cond = conditions.hide_in_disabled_ft,
		-- }

		local lsp = {
			function()
				local clients = vim.lsp.get_active_clients()
				local icon = " "
				local lsp = ""

				if next(clients) == nil then
					return lsp
				end

				local c = {}

				for _, client in pairs(clients) do
					table.insert(c, lsp_kind[client.name] or client.name)
				end

				-- local len = #c - 1
				-- lps = icon .. " " .. c[1]

				return #c > 0 and icon or ""
			end,
			padding = { left = 1, right = 2 },
			color = {
				fg = colors.green.base,
			},
			cond = conditions.hide_in_disabled_ft,
		}

		-- local navic = {
		-- 	function()
		-- 		local navic = require("nvim-navic")
		-- 		local ret = navic.get_location()
		-- 		return ret:len() > 2000 and "navic error" or ret
		-- 	end,
		-- 	cond = function()
		-- 		if package.loaded["nvim-navic"] then
		-- 			local navic = require("nvim-navic")
		-- 			return navic.is_available()
		-- 		end
		-- 	end,
		-- 	color = {
		-- 		bg = colors.bg0,
		-- 	},
		-- }

		local plugins = {
			function()
				return "󰦗  Updates"
			end,
			cond = function()
				return #plugin_checker.updated > 0
			end,
			color = {
				fg = colors.orange.dim,
				bg = colors.bg2,
			},
			separator = { right = "", left = "" },
		}

		-- local tasks = {
		-- 	"overseer",
		-- 	label = "", -- Prefix for task counts
		-- 	colored = true, -- Color the task icons and counts
		-- 	unique = false, -- Unique-ify non-running task count by name
		-- 	name = nil, -- List of task names to search for
		-- 	name_not = false, -- When true, invert the name search
		-- 	status = nil, -- List of task statuses to display
		-- 	status_not = false, -- When true, invert the status search
		-- }

		local macros = {
			"macro-recording",
			fmt = show_macro_recording,
			color = {
				fg = colors.white.bright,
				bg = colors.red.dim,
			},
			separator = { right = "", left = "" },
		}

		lualine.setup({
			options = {
				theme = "auto",
				icons_enabled = true,
				component_separators = "",
				section_separators = "",
			},
			sections = {
				lualine_a = {
					mode,
					plugins,
				},
				lualine_b = {
					-- filetype,
					-- filename,
				},
				lualine_c = {
					-- diff,
					-- diagnostics,
					-- navic,
				},
				lualine_x = {
					macros,
					location,
					spaces,
					encoding,
					treesitter,
					lsp,
				},
				lualine_y = {},
				lualine_z = {
					-- progress,
					status,
					branch,
				},
			},
			inactive_sections = {
				lualine_a = {
					mode,
				},
				lualine_b = {
					branch,
				},
				lualine_c = {
					diff,
				},
				lualine_x = {
					-- diagnostics,
					spaces,
					-- filetype,
				},
				lualine_y = { location },
				lualine_z = {
					progress,
				},
			},
			tabline = {},
			extensions = {},
		})
	end,
}
