local mocha = require("catppuccin.palettes").get_palette("mocha")

require("bufferline").setup({
	options = {
		mode = "buffers",
		offsets = {
			{
				filetype = "NvimTree",
				text = "Explorer",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "DiffviewFiles",
				text = "Diff View",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "packer",
				text = "Packer",
				highlight = "PanelHeading",
				padding = 1,
			},
		},
		indicator = {
			icon = "▎",
			style = "icon",
		},
		buffer_close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		separator_style = { "", "" },
		diagnostics = "nvim_lsp",
		show_close_icon = false,
	},
	highlights = require("catppuccin.groups.integrations.bufferline").get({
		styles = { "italic", "bold" },
		custom = {
			all = {
				fill = { bg = mocha.bg },
			},
			mocha = {
				background = { fg = mocha.text },
			},
			latte = {
				background = { fg = "#000000" },
			},
		},
	}),
})
