" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
set noshowmode

" Better display for messages
set cmdheight=1

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=50

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

if &compatible
 set nocompatible
endif

"set leader to ,
let mapleader = ',' 

set number relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set mouse=a
set clipboard+=unnamedplus

set wildignore+=*/node_modules/**/*
set wildignore+=*.aux

set diffopt+=vertical

set path+=./**
set wildoptions=pum
set conceallevel=0
set completeopt=menu,menuone,noselect
set scrolloff=8
set colorcolumn=120

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 50

autocmd BufEnter * :syntax sync fromstart
autocmd TermOpen * :setlocal signcolumn=no nonumber norelativenumber

syntax on
filetype plugin indent on
