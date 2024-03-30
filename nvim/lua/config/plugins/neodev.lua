local M = {
	"folke/neodev.nvim",
	lazy = false,
}

M.config = function()
	require("neodev").setup({
		library = { plugins = { "nvim-dap-ui" }, types = true },
	})
end

return M
