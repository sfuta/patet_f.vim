if exists('g:loaded_patet_f') && g:loaded_patet_f
  finish
endif
let g:loaded_patet_f = 1

let g:patet_f_enable     = get(g:, 'patet_f_enable', 1)
let g:patet_f_timeout_ms = get(g:, 'patet_f_timeout_ms', 0)
let g:patet_f_showmode   = get(g:, 'patet_f_showmode', &showmode)

" f mode operate keys
let g:patet_f_key_switch = get(g:, 'patet_f_key_switch', '<C-f>')
let g:patet_f_key_finish = get(g:, 'patet_f_key_finish', '<CR>')
let g:patet_f_key_escape = get(g:, 'patet_f_key_escape', '<Esc>')

" highright configs
highlight PatetFCursor term=reverse cterm=reverse
highlight PatetFCursorLine term=underline cterm=underline ctermbg=234

command! -nargs=+ CallPatetFStart call patet_f#start(<args>)

nnoremap <Plug>patet_f_r_n <Esc>:CallPatetFStart 0, "n"<CR>
nnoremap <Plug>patet_f_l_n <Esc>:CallPatetFStart 1, "n"<CR>
xnoremap <Plug>patet_f_r_x <Esc>:CallPatetFStart 0, "v"<CR>
xnoremap <Plug>patet_f_l_x <Esc>:CallPatetFStart 1, "v"<CR>
onoremap <Plug>patet_f_r_o <Esc>:CallPatetFStart 0, "o"<CR>
onoremap <Plug>patet_f_l_o <Esc>:CallPatetFStart 1, "o"<CR>

if !exists("g:patet_f_no_mappings") || !g:patet_f_no_mappings
  nmap f <Plug>patet_f_r_n
  nmap F <Plug>patet_f_l_n
  xmap f <Plug>patet_f_r_x
  xmap F <Plug>patet_f_l_x
  omap f <Plug>patet_f_r_o
  omap F <Plug>patet_f_l_o
endif
