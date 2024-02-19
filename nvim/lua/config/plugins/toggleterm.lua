local M = {
	"akinsho/toggleterm.nvim",
    enabled = false,
	-- keys = {
	-- 	{
	-- 		"<C-t>",
	-- 		function()
	-- 			vim.cmd("ToggleTerm")
	-- 		end,
	-- 		desc = "Toggles a terminal window",
	-- 	},
	-- },
	version = "*",
}

M.config = function()
	local toggleterm = require("toggleterm")

	toggleterm.setup({
		direction = "float",
		highlights = {
			NormalFloat = { link = "TelescopeNormal" },
			FloatBorder = { link = "TelescopeBorder" },
		},
	})
end

return M
