P = function(v)
	print(vim.inspect(v))
	return v
end

DiffViewToggle = function()
	local diffview = require("diffview.lib").get_current_view()

	if not diffview then
		vim.cmd("DiffviewOpen")
	else
		vim.cmd("DiffviewClose")
	end
end

vim.api.nvim_create_user_command("DiffViewToggle", DiffViewToggle, {})
