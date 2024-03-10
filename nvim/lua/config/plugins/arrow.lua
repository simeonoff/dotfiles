local M = {
	"otavioschwanck/arrow.nvim",
	event = "VeryLazy",
}

M.config = function()
	require("arrow").setup({})
end

return M
