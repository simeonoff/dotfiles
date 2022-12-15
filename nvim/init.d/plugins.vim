function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/plugged')

" Visuals "
Plug 'EdenEast/nightfox.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Utils
" Enables fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Search globally in all documents and output the result in a quickfix list.
Plug 'mhinz/vim-grepper'

" A collection of language packs (syntax, indent, etc.)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'tpope/vim-sensible'

" Provides mappings to easily delete, change targets.
Plug 'wellle/targets.vim'

" Short normal mode aliases for commonly used ex commands.
Plug 'tpope/vim-unimpaired', Cond(!exists('g:vscode'))

" Comment stuff out. Use gcc to comment out a line.
Plug 'numToStr/Comment.nvim'

" Make '.' work with plugin motions
Plug 'tpope/vim-repeat', Cond(!exists('g:vscode'))

" A minimal, stylish and customizable statusline / winbar for Neovim written in Lua
Plug 'nvim-lualine/lualine.nvim'
" Plug 'feline-nvim/feline.nvim', Cond(!exists('g:vscode'))

" Select text using Vim's visual mode, hit * to search for it in the file.
Plug 'nelstrom/vim-visual-star-search', Cond(!exists('g:vscode'))

" A snazzy buffer line (with tabpage integration) for Neovim built using lua.
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

" A File Explorer For Neovim Written In Lua
Plug 'nvim-tree/nvim-tree.lua'

" Align text automatically. http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plug 'godlygeek/tabular', Cond(!exists('g:vscode'))

" Read .editorconfig rules.
Plug 'editorconfig/editorconfig-vim', Cond(!exists('g:vscode'))

" Enables a file open in vim to be edited using another application and saved.
Plug 'djoshea/vim-autoread', Cond(!exists('g:vscode'))

" Select the current buffer only.
Plug 'vim-scripts/BufOnly.vim', Cond(!exists('g:vscode'))

" Version Control
Plug 'tpope/vim-fugitive', Cond(!exists('g:vscode'))
Plug 'tpope/vim-rhubarb', Cond(!exists('g:vscode'))
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'
 
" Presentations
Plug 'sotte/presenting.vim', Cond(!exists('g:vscode'))

" LSP
" Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Linter
Plug 'jose-elias-alvarez/null-ls.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

"  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'

" A pretty list for showing diagnostics, references, telescope results, quickfix and location lists.
Plug 'folke/trouble.nvim'

" Terminal toggler
Plug 'akinsho/toggleterm.nvim'

" Distraction free coding
Plug 'folke/zen-mode.nvim'

" Fix Cursor Hold
Plug 'antoinemadec/FixCursorHold.nvim', Cond(!exists('g:vscode'))

call plug#end()

" in millisecond, used for both CursorHold and CursorHoldI,
" use updatetime instead if not defined
let g:cursorhold_updatetime = 100

" highlight svelte 
let g:vim_svelte_plugin_load_full_syntax = 1
let g:vim_svelte_plugin_use_typescript = 1

" enable plugins comment
lua require('Comment').setup()
lua require("trouble").setup()
lua require("mason").setup()
lua require("mason-lspconfig").setup()
