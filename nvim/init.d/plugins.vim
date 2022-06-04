function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/plugged')

" Visuals "
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'bluz71/vim-moonfly-colors'

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
Plug 'sheerun/vim-polyglot', Cond(!exists('g:vscode'))

" Automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file.
Plug 'tpope/vim-sleuth', Cond(!exists('g:vscode'))

" Provides mappings to easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-surround', Cond(!exists('g:vscode'))

" Short normal mode aliases for commonly used ex commands.
Plug 'tpope/vim-unimpaired', Cond(!exists('g:vscode'))

" Comment stuff out. Use gcc to comment out a line.
Plug 'tpope/vim-commentary', Cond(!exists('g:vscode'))

" Kick off builds and test suites.
Plug 'tpope/vim-dispatch', Cond(!exists('g:vscode'))

" Make '.' work with plugin motions
Plug 'tpope/vim-repeat', Cond(!exists('g:vscode'))

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline', Cond(!exists('g:vscode'))
Plug 'vim-airline/vim-airline-themes', Cond(!exists('g:vscode'))

" Select text using Vim's visual mode, hit * to search for it in the file.
Plug 'nelstrom/vim-visual-star-search'

" Align text automatically. http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plug 'godlygeek/tabular', Cond(!exists('g:vscode'))

" Read .editorconfig rules.
Plug 'editorconfig/editorconfig-vim', Cond(!exists('g:vscode'))

" Enables a file open in vim to be edited using another application and saved.
Plug 'djoshea/vim-autoread', Cond(!exists('g:vscode'))

" Color highlighter for Neovim.
Plug 'norcalli/nvim-colorizer.lua'

" Select the current buffer only.
Plug 'vim-scripts/BufOnly.vim', Cond(!exists('g:vscode'))

" Use Ranger as the file manager
Plug 'francoiscabrol/ranger.vim', Cond(!exists('g:vscode'))
Plug 'rbgrouleff/bclose.vim', Cond(!exists('g:vscode'))

" Version Control
Plug 'tpope/vim-fugitive', Cond(!exists('g:vscode'))
Plug 'tpope/vim-rhubarb', Cond(!exists('g:vscode'))

" Eye candy
Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}

if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify', Cond(!exists('g:vscode'))
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" Presentations
Plug 'sotte/presenting.vim', Cond(!exists('g:vscode'))

" Language Server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fix Cursor Hold
Plug 'antoinemadec/FixCursorHold.nvim', Cond(!exists('g:vscode'))

call plug#end()

" in millisecond, used for both CursorHold and CursorHoldI,
" use updatetime instead if not defined
let g:cursorhold_updatetime = 100
