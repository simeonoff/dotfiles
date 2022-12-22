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
	local current = vim.api.nvim_get_current_buf()
	local bufs = vim.api.nvim_list_bufs()

	for _, buffer in pairs(bufs) do
		if vim.api.nvim_buf_is_loaded(buffer) then
			if buffer ~= current then
				vim.api.nvim_buf_call(buffer, function()
					vim.cmd("silent! write")
				end)
				vim.api.nvim_buf_delete(buffer, { force = false })
			end
		end
	end
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
