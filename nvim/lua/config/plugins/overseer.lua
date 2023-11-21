local M = {
	"stevearc/overseer.nvim",
	event = "BufReadPre",
	enabled = true,
}

M.config = function()
	require("overseer").setup()
end

return M
