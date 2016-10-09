if exists('g:loaded_patet_f') && g:loaded_patet_f
  finish
endif
let g:loaded_patet_f = 1

let g:patet_f_start_right_key = get(g:, 'patet_f_start_right_key', 'f')
let g:patet_f_start_left_key  = get(g:, 'patet_f_start_left_key',  'F')
let g:patet_f_enable          = get(g:, 'patet_f_enable', 1)
let g:patet_f_timeout_ms      = get(g:, 'patet_f_timeout_ms', 0)
let g:patet_f_showmode        = get(g:, 'patet_f_showmode', &showmode)

" f mode operate keys
let g:patet_f_key_switch = get(g:, 'patet_f_key_switch', '<C-f>')
let g:patet_f_key_finish = get(g:, 'patet_f_key_finish', '<CR>')
let g:patet_f_key_escape = get(g:, 'patet_f_key_escape', '<Esc>')

" highright configs
highlight PatetFCursor term=reverse cterm=reverse
highlight PatetFCursorLine term=underline cterm=underline ctermbg=234

command! -nargs=+ CallPatetFStart call patet_f#start(<args>)
exe 'nnoremap ' . g:patet_f_start_right_key . ' <Esc>:CallPatetFStart 0, "n"<CR>'
exe 'nnoremap ' . g:patet_f_start_left_key  . ' <Esc>:CallPatetFStart 1, "n"<CR>'
exe 'xnoremap ' . g:patet_f_start_right_key . ' <Esc>:CallPatetFStart 0, "v"<CR>'
exe 'xnoremap ' . g:patet_f_start_left_key  . ' <Esc>:CallPatetFStart 1, "v"<CR>'
exe 'onoremap ' . g:patet_f_start_right_key . ' <Esc>:CallPatetFStart 0, "o"<CR>'
exe 'onoremap ' . g:patet_f_start_left_key  . ' <Esc>:CallPatetFStart 1, "o"<CR>'

