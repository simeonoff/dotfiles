local M = {
	"jcdickinson/codeium.nvim",
	event = "InsertEnter",
	enabled = false,

	dependencies = {
		"hrsh7th/nvim-cmp",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
}

M.config = function()
	require("codeium").setup({})
end

return M
