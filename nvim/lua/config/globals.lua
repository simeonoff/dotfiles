local utils = require("utils")

P = function(v)
	print(vim.inspect(v))
	return v
end

vim.api.nvim_create_user_command("DiffviewToggle", utils.toggle_diffview, {})

vim.api.nvim_create_user_command("BufOnly", utils.delete_buffers, {})
