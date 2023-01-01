local M = {
	"ggandor/leap.nvim",
	event = "VeryLazy",

	dependencies = {
		{ "ggandor/flit.nvim", config = { labeled_modes = "nv" } },
	},

	config = function()
		require("leap").add_default_mappings()
		require("leap").opts.highlight_unlabeled_phase_one_targets = true
	end,
}

return M
