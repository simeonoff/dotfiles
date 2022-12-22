local utils = require("config.utils")

vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center the view when navigating down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center the view when navigation up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Center the view when going over next match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center the view when going over previous match" })

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual selection up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual selection down" })

vim.keymap.set(
	"n",
	"<leader>s",
	":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
	{ desc = "Rename the word under the cursor" }
)

vim.keymap.set(
	"n",
	"<leader>gx",
	utils.open_location,
	{ silent = true },
	{ desc = "Open the file/url under the cursor" }
)

vim.keymap.set("n", "<leader>gs", function()
	vim.cmd("DiffViewToggle")
end, { desc = "Toggle Diffview" })

vim.keymap.set("n", "<leader>gc", function()
	vim.cmd("tab Git commit")
end, { silent = true, desc = "Open git commit" })

vim.keymap.set("n", "<leader>gp", function()
	vim.cmd("Git push")
end, { silent = true, desc = "Git push" })

vim.keymap.set("n", "<leader>bd", require("bufdelete").bufdelete, { desc = "Deletes the current buffer" })

vim.keymap.set("n", "[b", function()
	vim.cmd("bprevious")
end, { desc = "Navigates to the previous buffer" })

vim.keymap.set("n", "]b", function()
	vim.cmd("bnext")
end, { desc = "Navigates to the next buffer" })
