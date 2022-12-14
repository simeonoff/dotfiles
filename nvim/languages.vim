" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" Remap keys for gotos
autocmd BufEnter * silent set winblend=5
if exists('g:vscode')
  "Add VSCode bindings here
  nnoremap <silent> ]p <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
  nnoremap <silent> [p <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>
else
  " Use `[p` and `]p` for navigate diagnostics
  nmap <silent> [p <Plug>(coc-diagnostic-prev)
  nmap <silent> ]p <Plug>(coc-diagnostic-next)

  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Clear search highlight by pressing <leader>/
  nmap <silent> <leader>/ :noh<CR>

  " Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if &filetype == 'vim'
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  vmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Use `:Format` for format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` for fold current buffer
  command! -nargs=? Fold :call CocAction('fold', <f-args>)

  " Use `:Prettier` to format using Prettier"
  command! -nargs=0 Prettier :CocCommand prettier.formatFile

  " Use `:Emulators` to list all Flutter Emulators
  command! -nargs=0 Emulators :CocList FlutterEmulators

  " Use `:FlutterRun` to start current project
  command! -nargs=0 FlutterRun :CocCommand flutter.run

  " Use `:FlutterAttach` to start current project
  command! -nargs=0 FlutterAttach :CocCommand flutter.attach

  " Hot restart a running flutter app
  nnoremap <silent> <space>r :<C-u>CocCommand flutter.dev.hotRestart<cr>

  " Using CocList
  " Show all diagnostics
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
endif

