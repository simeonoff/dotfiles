-- map leader 
vim.g.mapleader = ','

-- center view when navigating
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- handle url opening
if vim.fn.has("mac") == 1 then
  vim.api.nvim_set_keymap('n', 'gx', [[<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>]], { noremap = true, silent = true})
elseif vim.fn.has("unix") == 1 then
  vim.api.nvim_set_keymap('n', 'gx', [[<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>]], { noremap = true, silent = true})
else
  vim.api.nvim_set_keymap('n', 'gx', [[<Cmd>lua print("Error: gx is not supported on this OS!")<CR>]], { noremap = true, silent = true})
end
