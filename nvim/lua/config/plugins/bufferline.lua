return {
	"akinsho/bufferline.nvim",
	version = "v3.*",
	lazy = false,
	dependencies = {
		"EdenEast/nightfox.nvim",
	},

	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				mode = "buffers",
				offsets = {
					{
						filetype = "neo-tree",
						text = "Explorer",
						highlight = "NeoTreeNormal",
						padding = 1,
					},
					{
						filetype = "DiffviewFiles",
						text = "Diff View",
						highlight = "PanelHeading",
						padding = 1,
					},
				},
				indicator = {
					icon = "▎",
					style = "none",
				},
				buffer_close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				separator_style = { " ", " " },
				diagnostics = "nvim_lsp",
				show_close_icon = false,
			},
			highlights = {
				buffer_selected = { italic = false, bold = true },
				fill = {
					bg = { attribute = "bg", highlight = "NeoTreeNormal" },
				},
			},
		})
	end,
}
