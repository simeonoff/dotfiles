call plug#begin('~/.vim/plugged')

" Visuals "
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'bluz71/vim-moonfly-colors'

" Utils "
" Enables fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" A collection of language packs (syntax, indent, etc.)
Plug 'sheerun/vim-polyglot'

" Automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file.
Plug 'tpope/vim-sleuth'

" Provides mappings to easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-surround'

" Short normal mode aliases for commonly used ex commands.
Plug 'tpope/vim-unimpaired'

" Comment stuff out. Use gcc to comment out a line.
Plug 'tpope/vim-commentary'

" Kick off builds and test suites.
Plug 'tpope/vim-dispatch'

" Make '.' work with plugin motions
Plug 'tpope/vim-repeat'

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Select text using Vim's visual mode, hit * to search for it in the file.
Plug 'nelstrom/vim-visual-star-search'

" Align text automatically. http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plug 'godlygeek/tabular'

" Read .editorconfig rules.
Plug 'editorconfig/editorconfig-vim'

" Enables a file open in vim to be edited using another application and saved.
Plug 'djoshea/vim-autoread'

" Color highlighter for Neovim.
Plug 'norcalli/nvim-colorizer.lua'

" Select the current buffer only.
Plug 'vim-scripts/BufOnly.vim'

" Use Ranger as the file manager
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" Version Control "
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Eye candy
Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}

if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" Presentations "
Plug 'sotte/presenting.vim'

" Language Server "
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fix Cursor Hold
Plug 'antoinemadec/FixCursorHold.nvim'

call plug#end()

" in millisecond, used for both CursorHold and CursorHoldI,
" use updatetime instead if not defined
let g:cursorhold_updatetime = 100


