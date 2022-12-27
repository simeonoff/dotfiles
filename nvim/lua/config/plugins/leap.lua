local M = {
	"ggandor/leap.nvim",
    lazy = true,
	event = "VeryLazy",

	dependencies = {
		{ "ggandor/flit.nvim", config = { labeled_modes = "nv" } },
	},

	config = function()
		require("leap").add_default_mappings()
	end,
}

return M
