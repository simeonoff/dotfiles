local M = {
	"folke/neodev.nvim",
    lazy = false,
}

M.config = function()
	require("neodev").setup()
end

return M
