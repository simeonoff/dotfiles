local colorscheme = require("config.ui").colorscheme
local colors = require("nightfox.palette").load(colorscheme)
local window_width_limit = 100
local branch_icon = ""
local plugin_checker = require("lazy.manage.checker")

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.o.columns > window_width_limit
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
}

local branch = {
	"b:gitsigns_head",
	icon = branch_icon,
	color = {
		bg = colors.bg3,
		fg = colors.magenta.bright,
	},
}

local diff = {
	"diff",
	source = diff_source,
	symbols = {
		added = "+" .. " ",
		modified = "~" .. " ",
		removed = "-" .. " ",
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
		error = "●" .. " ",
		warn = "●" .. " ",
		info = "●" .. " ",
		hint = "●" .. " ",
	},
}

local treesitter = {
	function()
		return "TS"
	end,
	color = function()
		local buf = vim.api.nvim_get_current_buf()
		local ts = vim.treesitter.highlighter.active[buf]
		return { fg = ts and not vim.tbl_isempty(ts) and colors.green.base or colors.red.base }
	end,
	cond = conditions.hide_in_width,
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

local filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } }

local lsp = {
	function(msg)
		msg = msg or "LSP Inactive"
		local buf_clients = vim.lsp.buf_get_clients()
		if next(buf_clients) == nil then
			-- TODO: clean up this if statement
			if type(msg) == "boolean" or #msg == 0 then
				return "LSP Inactive"
			end
			return msg
		end

		if rawget(vim, "lsp") then
			for _, client in ipairs(vim.lsp.get_active_clients()) do
				if client.attached_buffers[vim.api.nvim_get_current_buf()] then
					if client.name ~= "null-ls" then
						return (vim.o.columns > 100 and "%#St_LspStatus#" .. client.name) or "LSP"
					end
				end
			end
		end
	end,
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
		return "○ Pending Updates ○"
	end,
	cond = function()
		return #plugin_checker.updated > 0
	end,
	color = {
		fg = colors.magenta.bright,
		bg = colors.bg2,
	},
}

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,

	config = function()
		local lualine = require("lualine")

		lualine.setup({
			options = {
				theme = "auto",
				icons_enabled = true,
				component_separators = "",
				section_separators = "",
				disabled_filetypes = {},
			},
			sections = {
				lualine_a = {
					mode,
				},
				lualine_b = {
					plugins,
				},
				lualine_c = {
					diff,
					-- navic,
				},
				lualine_x = {
					diagnostics,
					treesitter,
					lsp,
					encoding,
					spaces,
					location,
				},
				lualine_y = {},
				lualine_z = {
					-- progress,
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
					diagnostics,
					spaces,
					filetype,
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
