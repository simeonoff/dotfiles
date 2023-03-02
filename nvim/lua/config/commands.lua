local utils = require("utils")
local group_id = vim.api.nvim_create_augroup("rooter", { clear = true })
local personal_augroup = vim.api.nvim_create_augroup("personal_augroup", { clear = true })
local bufonly = require("bufonly")

vim.api.nvim_create_user_command("BufOnly", function()
	bufonly.BufOnly()
end, {})

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

-- Change conceallevel for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "md", "markdown" },
	callback = function()
		vim.wo.conceallevel = 0
	end,
	group = personal_augroup,
})

-- Enable spellchecking for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "md", "markdown", "gitcommit" },
	command = "setlocal spell",
	group = personal_augroup,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	group = personal_augroup,
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
	group = personal_augroup,
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
				root = utils.get_root()
				vim.api.nvim_buf_set_var(0, "root_dir", root)
			end

			if root ~= nil then
				vim.api.nvim_set_current_dir(root)
			end
		end
	end,
})
