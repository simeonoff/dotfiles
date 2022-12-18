-- if hidden is not set, TextEdit might fail
vim.opt.hidden = true

-- leave space to for the command line
vim.opt.cmdheight = 1

-- always show signcolumns
vim.opt.signcolumn = "yes"

-- show the relative numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- highlight the cursorline
vim.opt.cursorline = true

-- configure tab with
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- enable smartindent
vim.opt.smartindent = true

-- enable mouse support
vim.opt.mouse = "a"

-- do not highlight search matches
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- colors and column width
vim.opt.colorcolumn = "120"

-- row offset number before scrolling
vim.opt.scrolloff = 8

-- do not try to conceal characters
vim.opt.conceallevel = 0

-- configure completion menu
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- configure clipboard
vim.opt.clipboard = "unnamedplus"

-- ignore node_modules folders
vim.opt.wildignore = "*/node_modules/**/*"

-- Smaller updatetime for CursorHold & CursorHoldI
vim.opt.updatetime = 50

-- enable gui colors
vim.opt.termguicolors = true
