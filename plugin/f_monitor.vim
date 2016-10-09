if exists('g:loaded_f_monitor') && g:loaded_f_monitor
  finish
endif
let g:loaded_f_monitor = 1

let g:small_f_monitor_start_key = get(g:, 'small_f_monitor_start_key', 'f')
let g:large_f_monitor_start_key = get(g:, 'large_f_monitor_start_key', 'F')
let g:f_monitor_enable          = get(g:, 'f_monitor_enable', 1)
let g:f_monitor_timeout_ms      = get(g:, 'f_monitor_timeout_ms', 0)
let g:f_monitor_showmode        = get(g:, 'f_monitor_showmode', &showmode)

" TODO キー名で設定可能
" f mode operate keys
let g:f_monitor_keycode_switch = get(g:, 'f_monitor_keycode_switch', 6)
let g:f_monitor_keycode_finish = get(g:, 'f_monitor_keycode_finish', 13)
let g:f_monitor_keycode_escape = get(g:, 'f_monitor_keycode_escape', 27)

" highright configs
highlight FMonitorCursor term=reverse cterm=reverse
highlight FMonitorCursorLine term=underline cterm=underline ctermbg=234
let g:f_monitor_mark_cursor_color = get(g:, 'f_monitor_mark_cursor_color', 'FMonitorCursor')
let g:f_monitor_mark_cursor_line  = get(g:, 'f_monitor_mark_cursor_line' , 'FMonitorCursorLine')

command! -nargs=+ CallFMonitorStart call f_monitor#start(<args>)
exe 'nnoremap ' . g:small_f_monitor_start_key . ' <Esc>:CallFMonitorStart 0, "n"<CR>'
exe 'nnoremap ' . g:large_f_monitor_start_key . ' <Esc>:CallFMonitorStart 1, "n"<CR>'
exe 'xnoremap ' . g:small_f_monitor_start_key . ' <Esc>:CallFMonitorStart 0, "v"<CR>'
exe 'xnoremap ' . g:large_f_monitor_start_key . ' <Esc>:CallFMonitorStart 1, "v"<CR>'
exe 'onoremap ' . g:small_f_monitor_start_key . ' <Esc>:CallFMonitorStart 0, "o"<CR>'
exe 'onoremap ' . g:large_f_monitor_start_key . ' <Esc>:CallFMonitorStart 1, "o"<CR>'

