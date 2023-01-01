local M = {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
}

M.config = function()
	local notify = require("notify")

	notify.setup({
		stages = "static",
		timeout = 3000,
		level = vim.log.levels.INFO,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
	})

	vim.notify = notify
end

return M
