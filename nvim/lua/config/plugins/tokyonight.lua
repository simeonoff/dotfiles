local M = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
    enabled = false
}

M.config = function()
	local colorscheme = require("config.ui").colorscheme

	require("tokyonight").setup({
		style = "night",
	})

	vim.cmd.colorscheme(colorscheme)
end

return M
