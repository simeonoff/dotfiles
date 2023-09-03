local M = {
	"ggandor/leap.nvim",
	event = "VeryLazy",

	dependencies = {
		{ "ggandor/flit.nvim", opts = {
			labeled_modes = "nv",
			multiline = true,
		} },
	},
}

return M
