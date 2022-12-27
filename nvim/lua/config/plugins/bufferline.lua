return {
	"akinsho/bufferline.nvim",
	version = "v3.*",
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
				separator_style = "thick",
				diagnostics = "nvim_lsp",
				show_close_icon = false,
			},
		})
	end,
}
