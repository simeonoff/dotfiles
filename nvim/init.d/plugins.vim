call plug#begin('~/.vim/plugged')

" Visuals "
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'

" Utils "
" Enables fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

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

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Select text using Vim's visual mode, hit * to search for it in the file.
Plug 'nelstrom/vim-visual-star-search'

" Align text automatically. http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plug 'godlygeek/tabular'

" Syntax highlighting, matching rules and mappings for the original Markdown and extensions.  
Plug 'plasticboy/vim-markdown'

" Read .editorconfig rules.
Plug 'editorconfig/editorconfig-vim'

" Enables a file open in vim to be edited using another application and saved.
Plug 'djoshea/vim-autoread'

" Enables CSS syntax highlighting in JS files.
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Color highlighter for Neovim.
Plug 'norcalli/nvim-colorizer.lua'

" Select the current buffer only.
Plug 'vim-scripts/BufOnly.vim'

" Version Control "
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" Presentations "
Plug 'sotte/presenting.vim'

" Language Server "
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

