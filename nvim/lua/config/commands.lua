local utils = require("utils")
local group_id = vim.api.nvim_create_augroup("rooter", { clear = true })

vim.api.nvim_create_user_command("BufOnly", utils.delete_buffers, {})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
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

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Add keyboard navigation for terminals
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = {
		"term://*",
	},
	callback = function()
		local opts = { buffer = 0 }
		vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
		vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
		vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
		vim.keymap.set("t", "<C-t>", [[<Cmd>ToggleTerm<CR>]])
	end,
})

-- Change current work directory to root of the buffer
vim.api.nvim_create_autocmd("BufRead", {
	group = group_id,
	callback = function()
		vim.api.nvim_buf_set_var(0, "root_dir", nil)
	end,
})

-- Change the current working directory to the root dir of the buffer
vim.api.nvim_create_autocmd("BufEnter", {
	group = group_id,
	nested = true,
	callback = function()
		local ft = vim.bo.filetype

		if ft ~= "neo-tree" then
			local root = vim.fn.exists("b:root_dir") == 1 and vim.api.nvim_buf_get_var(0, "root_dir") or nil
			if root == nil then
				root = require("utils").get_root()
				vim.api.nvim_buf_set_var(0, "root_dir", root)
			end

			if root ~= nil then
				vim.api.nvim_set_current_dir(root)
			end
		end
	end,
})
