local utils = require("utils")

-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center the view when navigating down" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center the view when navigation up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Center the view when going over next match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center the view when going over previous match" })

-- from Primeagen
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual selection up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual selection down" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode" })

-- greatest remap
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Replace highlighted text from what's in the void registry" })

-- rename the word under the cursor
vim.keymap.set({ "n", "x" }, "<leader>s", utils.rename_cword, { desc = "Rename the word under the cursor" })

-- Open the URI under the cursor
vim.keymap.set("n", "<leader>gx", utils.open_location, { silent = true, desc = "Open the file/url under the cursor" })

vim.keymap.set("n", "<leader>gs", function()
	vim.cmd("Git status")
end, { desc = "Toggle git status view" })

vim.keymap.set("n", "<leader>gc", function()
	vim.cmd("tab Git commits")
end, { silent = true, desc = "Open git commits" })

vim.keymap.set("n", "<leader>bo", function()
	vim.cmd("BufOnly")
end, { desc = "Deletes all buffers except the current one" })

vim.keymap.set("n", "[b", function()
	local ft = vim.bo.filetype
	if ft ~= "neo-tree" then
		vim.cmd("bprevious")
	end
end, { desc = "Navigates to the previous buffer" })

vim.keymap.set("n", "]b", function()
	local ft = vim.bo.filetype
	if ft ~= "neo-tree" then
		vim.cmd("bnext")
	end
end, { desc = "Navigates to the next buffer" })

vim.keymap.set("n", "<leader>i", function()
	vim.cmd("Format")
end, { desc = "Format buffer" })

vim.keymap.set("n", "<C-e>", function()
	vim.cmd("Oil --float")
end, { desc = "Pull up file browser" })

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
