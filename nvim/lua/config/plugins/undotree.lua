local M = {
	"mbbill/undotree",
	event = "BufReadPre",
	enabled = true,
}

M.config = function()
	vim.keymap.set("n", "<leader>u", function()
		vim.cmd("UndotreeToggle")
	end, { desc = "Toggle undotree" })
end

return M
