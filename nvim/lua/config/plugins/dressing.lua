---@diagnostic disable: different-requires
local M = {
	"stevearc/dressing.nvim",
}

M.init = function()
	local lazy = require("lazy")

	vim.ui.select = function(...)
		lazy.load({ plugins = { "dressing.nvim" } })
		return vim.ui.select(...)
	end
	vim.ui.input = function(...)
		lazy.load({ plugins = { "dressing.nvim" } })
		return vim.ui.input(...)
	end
end

M.config = function()
	require("dressing").setup({
		input = {
			border = "solid",
			prompt_align = "center",
			win_options = {
				winblend = 0,
			},
		},
	})
end

return M
