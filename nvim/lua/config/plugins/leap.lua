local M = {
	"ggandor/leap.nvim",
	event = "VeryLazy",

	dependencies = {
		{ "ggandor/flit.nvim", config = {
			labeled_modes = "nv",
			multiline = true,
		} },
	},
}

return M
