let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_skip_empty_sections = 0
let g:airline_theme = 'moonfly'
let g:airline_detect_spell = 1
let g:airline#extensions#coc#enabled = 1
let g:airline_section_c = airline#section#create(["%{get(g:, 'coc_status', '')}"])

let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
