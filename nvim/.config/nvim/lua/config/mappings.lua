local utils = require('utils')
local map = vim.keymap.set

-- from Primeagen
map('n', 'n', 'nzzzv', { desc = 'Center the view when going over next match' })
map('n', 'N', 'Nzzzv', { desc = 'Center the view when going over previous match' })

map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move visual selection up' })
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move visual selection down' })
map('n', 'J', 'mzJ`z', { desc = 'Join lines and keep cursor position' })
map('n', 'Q', '<nop>', { desc = 'Disable Ex mode' })
map('n', 'Q', '<nop>', { desc = 'Disable Ex mode' })

-- greatest remap
map('x', '<leader>p', [["_dP]], { desc = "Replace highlighted text from what's in the void registry" })

-- rename the word under the cursor
map({ 'n', 'x' }, '<leader>s', utils.rename_cword, { desc = 'Rename the word under the cursor' })

-- Open the URI under the cursor
map('n', '<leader>gx', utils.open_location, { silent = true, desc = 'Open the file/url under the cursor' })

map('n', '<leader>gs', function() vim.cmd('Git status') end, { desc = 'Toggle git status view' })

map('n', '<leader>gc', function() vim.cmd('tab Git commits') end, { silent = true, desc = 'Open git commits' })

map('n', '<C-Right>', function() utils.navigate('l') end, { noremap = true, silent = true })

map('n', '<C-Left>', function() utils.navigate('h') end, { noremap = true, silent = true })

map('n', '<C-Up>', function() utils.navigate('k') end, { noremap = true, silent = true })

map('n', '<C-Down>', function() utils.navigate('j') end, { noremap = true, silent = true })
