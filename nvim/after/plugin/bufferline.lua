require("bufferline").setup({
	options = {
		mode = "buffers",
		offsets = {
			{ filetype = "NvimTree" },
		},
		separator_style = { "", "" },
		diagnostics = "nvim_lsp",
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
