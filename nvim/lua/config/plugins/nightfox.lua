local M = {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 999,
	enable = true,
}

M.colorscheme = "nordfox"

M.config = function()
	require("nightfox").setup()
	vim.cmd.colorscheme(M.colorscheme)
end

return M
