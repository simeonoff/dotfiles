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
		modified_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		separator_style = { "", "" },
		diagnostics = "nvim_lsp",
		show_close_icon = false,
	},
	highlights = {
		buffer_selected = {
			italic = false,
		},
		indicator_selected = {
			fg = { attribute = "fg", highlight = "Function" },
			italic = false,
		},
	},
})
