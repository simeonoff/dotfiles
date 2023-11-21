local M = {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	enabled = false,
}

local colorscheme = require("config.ui").colorscheme

M.config = function()
	require("catppuccin").setup({
		flavour = "mocha",
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
		},
	})

	vim.cmd.colorscheme(colorscheme)
end

return M
