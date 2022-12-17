" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" Remap keys for gotos
autocmd BufEnter * silent set winblend=5
if exists('g:vscode')
  "Add VSCode bindings here
  nnoremap <silent> ]p <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
  nnoremap <silent> [p <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>
else

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

