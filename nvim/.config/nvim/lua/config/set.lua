vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- if hidden is not set, TextEdit might fail
vim.opt.hidden = true

-- always show signcolumns
vim.opt.signcolumn = 'yes'
vim.opt.ruler = false

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

-- copy indent from current line when starting a new line
vim.opt.autoindent = true

-- enable mouse support
vim.opt.mouse = 'a'

-- do not highlight search matches
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- ignore case when searching
vim.opt.ignorecase = true

-- Configure backspace behavior in insert mode to allow deleting over line starts, end-of-line characters, and indentation.
vim.opt.backspace = { 'start', 'eol', 'indent' }

-- colors and column width
vim.opt.colorcolumn = '120'

-- row offset number before scrolling
vim.opt.scrolloff = 8

-- do not try to conceal characters
vim.opt.conceallevel = 3

-- configure completion menu
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- configure clipboard
vim.opt.clipboard = 'unnamedplus'

-- ignore node_modules folders
vim.opt.wildignore = '*/node_modules/**/*'

-- Smaller updatetime for CursorHold & CursorHoldI
vim.opt.updatetime = 250

-- enable gui colors
vim.opt.termguicolors = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set commandline behavior
vim.opt.showmode = false

-- set global statusline
vim.go.laststatus = 3

-- set spelling
vim.opt.spelllang = { 'en_us' }
vim.opt.spell = false
vim.opt.spellsuggest = 'best,8'

vim.opt.pumblend = 0 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current

-- set folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldcolumn = '0'
vim.opt.foldtext = ''

vim.opt.undofile = true
vim.opt.undolevels = 10000

vim.opt.backup = true
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }

if vim.fn.has('nvim-0.8') == 1 then
  vim.opt.backupdir = vim.fn.stdpath('state') .. '/backup'
end

-- Reduce the height of the command line
vim.opt.cmdheight = 0

-- Disable tmux navigator when zooming the vim pane
vim.g.tmux_navigator_disable_when_zoomed = 1

-- If the tmux window is zoomed, keep it zoomed when moving from vim to another pane
vim.g.tmux_navigator_preserve_zoom = 1

-- Disable intro screen
vim.opt.shortmess:append({ I = true })

-- Disable tilde for empty lines
vim.opt.fillchars = { eob = ' ' }

-- Set list characters
vim.opt.listchars = 'tab:->,trail:·,space:·'

-- Disable swap files globally
vim.opt.swapfile = false
