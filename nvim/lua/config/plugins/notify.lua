local M = {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
}

M.config = function()
	local notify = require("notify")
	notify.setup({
		config = {
			timeout = 3000,
			level = vim.log.levels.INFO,
			fps = 60,
			---@usage Animation style one of { "fade", "slide", "fade_in_slide_out", "static" }
			stages = "static",
			-- Render function for notifications. See notify-render()
			render = "default",
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
	})
	vim.notify = notify
end
return M
