local M = {
	"Exafunction/windsurf.nvim",
	cmd = "Codeium",
	event = "InsertEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
}

M.config = function()
	require("codeium").setup({})
end

return M
