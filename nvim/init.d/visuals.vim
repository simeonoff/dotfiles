if exists('g:vscode')
else
  set termguicolors

  set pumblend=8
  highlight PmenuSel blend=0
  set background=dark

  colorscheme catppuccin

  " hi Normal guibg=NONE ctermbg=NONE
  " hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
endif

