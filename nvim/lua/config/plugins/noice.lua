local M = {
	"folke/noice.nvim",
	event = "VeryLazy",

	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}

M.config = function()
	local notify = require("notify")

	---@diagnostic disable: missing-fields
	notify.setup({
		stages = "static",
		fps = 120,
		icons = {
			DEBUG = " ",
			ERROR = " ",
			INFO = " ",
			TRACE = " ",
			WARN = " ",
		},
		timeout = 3000,
		level = vim.log.levels.INFO,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
	})

	require("noice").setup({
		cmdline = {
			view = "cmdline_popup",
			enabled = true,
			format = {
				cmdline = { pattern = "^:", icon = "󰅂", lang = "vim", title = "Command" },
				lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = " ", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "󱔢 " },
				search_down = { kind = "search", pattern = "^/", icon = " Search Down:", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = " Search Up:", lang = "regex" },
			},
		},
		lsp = {
			hover = {
				enabled = false,
			},
			signature = {
				enabled = false,
			},
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
		},
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
		views = {
			cmdline_popup = {
				position = {
					row = "7%",
					col = "50%",
				},
			},
		},
	})
end

return M
