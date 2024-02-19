local M = {
	"stevearc/overseer.nvim",
	event = "BufReadPre",
	enabled = false,
}

M.config = function()
	require("overseer").setup()
end

return M
