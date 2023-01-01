local utils = require("utils")

P = function(v)
	print(vim.inspect(v))
	return v
end

vim.api.nvim_create_user_command("BufOnly", utils.delete_buffers, {})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"qf",
		"help",
		"man",
        "notify"
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Fix conceallevel for json & help files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})
