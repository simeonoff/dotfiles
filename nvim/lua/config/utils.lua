local M = {}

M.open_location = function()
	local loc = vim.fn.expand("<cfile>")
	local executable = nil

	if vim.fn.has("mac") == 1 then
		executable = "open"
	elseif vim.fn.has("unix") == 1 then
		executable = "xdg-open"
	end

	if executable then
		vim.loop.spawn(executable, {
			args = { loc },
		})
	else
		print("Error: opening locations is not supported on this OS")
	end
end

M.delete_buffers = function()
	vim.cmd("%bd|e#|bd#")
end

M.toggle_diffview = function()
	local diffview = require("diffview.lib").get_current_view()

	if not diffview then
		vim.cmd("DiffviewOpen")
	else
		vim.cmd("DiffviewClose")
	end
end

return M
