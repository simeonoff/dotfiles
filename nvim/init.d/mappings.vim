" Easily switch between buffers
nnoremap <silent> gfn :!echo % \| xclip<CR>

if exists('g:vscode')
  "Add VSCode bindings here
  nnoremap <silent> <leader>i <Cmd>call VSCodeNotify('editor.action.format')<CR>
  nnoremap <silent> <leader>f <Cmd>call VSCodeNotify('workbench.files.action.focusFilesExplorer')<CR>
  nnoremap <silent> ]b :Tabnext<CR>
  nnoremap <silent> [b :Tabprevious<CR>

  nnoremap Git <Cmd>call VSCodeNotify('workbench.view.scm')<CR>
  command! -nargs=0 Git :call VSCodeNotify('workbench.view.scm')
  command! -nargs=0 Gstage :call VSCodeNotify('git.stageAll')
  command! -nargs=0 Gcommit :call VSCodeNotify('git.commit')
  command! -nargs=0 Gpush :call VSCodeNotify('git.push')
  command! -nargs=0 Gpull :call VSCodeNotify('git.pull')

  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine
else
  nnoremap <silent> <leader>i :Format<CR>
  nnoremap <silent> <leader>] :exe "vertical resize " . (winwidth(0) + 30)<CR>
  nnoremap <silent> <leader>[ :exe "vertical resize " . (winwidth(0) - 30)<CR>

  nnoremap <C-p> :Telescope find_files<CR>
  noremap <C-F> :Telescope live_grep<CR>

  nnoremap <leader>bb :Telescope buffers<CR>
  nnoremap <leader><tab> :b#<cr>

  " Switch git branches
  nnoremap <leader>gb :Telescope git_branches<CR>

  " Angular mappings
  nnoremap <silent> <leader>at /@Component<CR>/templateUrl<CR>:noh<CR>f'gf<ESC>
  nnoremap <silent> <leader>as /@Component<CR>/styleUrl<CR>:noh<CR>f'gf<ESC>

  nnoremap <silent> <leader>= :exe "resize " . (winheight(0) + 10)<CR>
  nnoremap <silent> <leader>- :exe "resize " . (winheight(0) - 10)<CR>

  " Use <C-l> for trigger snippet expand.
  imap <C-l> <Plug>(coc-snippets-expand)

  " Use <C-j> for select text for visual placeholder of snippet.
  vmap <C-j> <Plug>(coc-snippets-select)

  " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_next = '<c-j>'

  " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  let g:coc_snippet_prev = '<c-k>'

  " Use <C-j> for both expand and jump (make expand higher priority.)
  imap <C-j> <Plug>(coc-snippets-expand-jump)
endif

function! ToggleSpecFile()
  let l:file = expand('%')
  if empty(matchstr(l:file, '\.spec\.ts'))
    let l:spec_file = substitute(l:file, '\.ts$', '\.spec.ts', '')
    if filereadable(l:spec_file)
      execute 'e' l:spec_file
    else
      echo "No spec file found!"
    endif
  else
    let l:normal_file = substitute(l:file, '\.spec\.ts$', '\.ts', '')
    if filereadable(l:normal_file)
      execute 'e' l:normal_file
    else
      echo "No file found!"
    endif
  endif
endfunction

" Find Angular spec file.
nnoremap <silent> <leader>sp :call ToggleSpecFile()<CR>

