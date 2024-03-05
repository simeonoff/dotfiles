return {
	"akinsho/bufferline.nvim",
	version = "v3.*",
	lazy = false,
    enabled = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
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
				color_icons = false,
				show_buffer_icons = false,
				indicator = {
					icon = "▎",
					style = "none",
				},
				separator_style = { " ", " " },
				diagnostics = "nvim_lsp",
				show_close_icon = false,
                buffer_close_icon = ' ',
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
