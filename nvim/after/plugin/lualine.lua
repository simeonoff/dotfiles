local colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	purple = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

local window_width_limit = 100

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

local branch_icon = ""

local mode = {
	function()
		return " " .. " " .. " "
	end,
	padding = { left = 0, right = 0 },
	color = {},
	cond = nil,
}

local branch = {
	"b:gitsigns_head",
	icon = branch_icon,
	color = { gui = "bold" },
}

--[[ local filename = {
	"filename",
	color = {},
	cond = nil,
} ]]

local diff = {
	"diff",
	source = diff_source,
	symbols = {
		added = "" .. " ",
		modified = "" .. " ",
		removed = "" .. " ",
	},
	padding = { left = 2, right = 1 },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.yellow },
		removed = { fg = colors.red },
	},
	cond = nil,
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = {
		error = "" .. " ",
		warn = "" .. " ",
		info = "" .. " ",
		hint = "" .. " ",
	},
}

local treesitter = {
	function()
		return ""
	end,
	color = function()
		local buf = vim.api.nvim_get_current_buf()
		local ts = vim.treesitter.highlighter.active[buf]
		return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
	end,
	cond = conditions.hide_in_width,
}

local lsp = {
	function(msg)
		msg = msg or "LS Inactive"
		local buf_clients = vim.lsp.buf_get_clients()
		if next(buf_clients) == nil then
			-- TODO: clean up this if statement
			if type(msg) == "boolean" or #msg == 0 then
				return "LS Inactive"
			end
			return msg
		end
		local buf_ft = vim.bo.filetype
		local buf_client_names = {}
		local copilot_active = false

		-- add client
		for _, client in pairs(buf_clients) do
			if client.name ~= "null-ls" and client.name ~= "copilot" then
				table.insert(buf_client_names, client.name)
			end

			if client.name == "copilot" then
				copilot_active = true
			end
		end

		-- add formatter
		local formatters = require("null-ls.formatters")
		local supported_formatters = formatters.list_registered(buf_ft)
		vim.list_extend(buf_client_names, supported_formatters)

		-- add linter
		local linters = require("null-ls.linters")
		local supported_linters = linters.list_registered(buf_ft)
		vim.list_extend(buf_client_names, supported_linters)

		local unique_client_names = vim.fn.uniq(buf_client_names)

		local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

		if copilot_active then
			language_servers = language_servers .. "%#SLCopilot#" .. " " .. "" .. "%*"
		end

		return language_servers
	end,
	color = { gui = "bold" },
	cond = conditions.hide_in_width,
}

local location = { "location" }

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
		return "" .. " " .. shiftwidth
	end,
	padding = 1,
}

local encoding = {
	"o:encoding",
	fmt = string.upper,
	color = {},
	cond = conditions.hide_in_width,
}

local filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } }

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
		icons_enabled = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha" },
	},
	sections = {
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
			lsp,
			spaces,
			filetype,
		},
		lualine_y = { location },
		lualine_z = {
			progress,
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
			encoding,
			treesitter,
			lsp,
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
