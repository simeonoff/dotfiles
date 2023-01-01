vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- if hidden is not set, TextEdit might fail
vim.opt.hidden = true

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

-- Don't ignore case with capitals
vim.opt.smartcase = true

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
vim.opt.conceallevel = 3

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

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set commandline behavior
vim.opt.showmode = false

-- set global statusline
vim.go.laststatus = 3

vim.opt.fillchars = {
	--   horiz = "━",
	--   horizup = "┻",
	--   horizdown = "┳",
	--   vert = "┃",
	--   vertleft = "┫",
	--   vertright = "┣",
	--   verthoriz = "╋",im.o.fillchars = [[eob: ,
	-- fold = " ",
	foldopen = "",
	-- foldsep = " ",
	foldclose = "",
}

-- Show some invisible characters (tabs...
vim.opt.list = true

vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

vim.opt.undofile = true
vim.opt.undolevels = 10000

vim.opt.backup = true
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

if vim.fn.has("nvim-0.8") == 1 then
	vim.opt.cmdheight = 0
	vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"
end
