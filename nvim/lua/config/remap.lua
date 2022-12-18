-- map leader
vim.g.mapleader = ","

-- center view when navigating
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- move lines easily in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- rename the word under the cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- handle url/file opening
if vim.fn.has("mac") == 1 then
	vim.keymap.set(
		"n",
		"<leader>gx",
		":call jobstart(['open', expand('<cfile>')], {'detach': v:true})<CR>",
		{ silent = true }
	)
elseif vim.fn.has("unix") == 1 then
	vim.keymap.set(
		"n",
		"<leader>gx",
		":call jobstart(['xdg-open', expand('<cfile>')], {'detach': v:true})<CR>",
		{ silent = true }
	)
else
	vim.keymap.set("n", "<leader>gx", function()
		print("Error: gx is not supported on this OS")
	end)
end
