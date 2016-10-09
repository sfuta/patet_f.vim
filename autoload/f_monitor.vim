"TODO
" - ライセンスとか。。

let s:save_cpo = &cpo
set cpo&vim

let s:is_reverse   = 0
let s:current_mode = "n"
let s:operator     = ""

function! f_monitor#start(is_rev, current_mode)
  if g:f_monitor_enable == 0
    return
  endif

  try
    " init
    echo ""
    let s:is_reverse   = a:is_rev
    let s:current_mode = a:current_mode
    let s:operator     = v:operator

    let s:keycode_switch = s:char2nr(g:f_monitor_key_switch)
    let s:keycode_finish = s:char2nr(g:f_monitor_key_finish)
    let s:keycode_escape = s:char2nr(g:f_monitor_key_escape)

    let s:showmode = &showmode
    set noshowmode

    highlight link FMonitorDynamicCursorColor FMonitorCursor
    highlight link FMonitorDynamicCursorLine  FMonitorCursorLine

    " main
    call s:main()

  finally
    " destruct
    highlight link FMonitorDynamicCursorColor NONE
    highlight link FMonitorDynamicCursorLine  NONE

    let &showmode = s:showmode
    echo ""
    redraw
  endtry

endfunction

function! s:char2nr(key_name)
  exe 'return strpart(a:key_name, 0, 1) == "<" ? char2nr("\' . a:key_name . '") : char2nr(a:key_name)'
endfunction

" Returned time lag
" @param  list b_time before timestamp
" @param  list a_time after  timestamp
" @return number lag(ms)
function! s:timelag(b_time, a_time)
  let l:timelag = str2float(reltimestr(reltime(a:b_time, a:a_time)))
  return float2nr(l:timelag * 1000.0)
endfunction

" Workaround for the <expr> mappings
function! s:getchar(...)
  let l:mode = get(a:, 1, 0)
  while 1
    let l:char = call("getchar", a:000)
    " Interrupt Enabled
    "try
    "catch /^Vim:Interrupt$/
    "  let l:char = 3 " <C-c>
    "endtry
    " Workaround for the <expr> mappings
    if string(l:char) !=# "\x80\xfd`"
      return mode != 1 ? l:char : !!l:char
    endif
  endwhile
endfunction

" timeout with getchar()
function! s:getchar_timeout(timeout_lag_ms, last_pressed_time)
  if a:timeout_lag_ms > 0
    while 1
      let l:c = s:getchar(0)
      if s:timelag(a:last_pressed_time, reltime()) > a:timeout_lag_ms
        return s:keycode_finish
      endif
      if l:c != 0 | break | endif
    endwhile
  else
    let l:c = s:getchar()
  endif
  return l:c
endfunction

function! s:showModeMessage()
  if g:f_monitor_showmode == 0
    return
  endif
  let l:f_type   = s:is_reverse == 0 ? 'f' : 'F'
  let l:mode     = s:current_mode == 'v' ? ' VISUAL' : ''
  let l:operator = s:current_mode == 'o' ? s:operator : ''

  echo '-- ' . l:operator . l:f_type . ' MOVE' . l:mode . ' --'
endfunction

function! s:main()

  let l:count = v:prevcount ? v:prevcount : 1

  if s:current_mode == 'o' | exe "normal! \<Esc>v\<Esc>" | endif
  if s:current_mode == 'v' | exe "normal! \<Esc>gv" | endif

  let l:cursor_line = matchadd("FMonitorDynamicCursorLine",  '\%' . line(".") . 'l.*', 999)

  let l:is_first  = 1

  while 1

    call s:showModeMessage()

    let l:cursor_mark = matchadd("FMonitorDynamicCursorColor", '\%#', 999)
    redraw

    let l:char  = l:is_first ? s:getchar() : s:getchar_timeout(g:f_monitor_timeout_ms, reltime())
    let l:count = l:is_first ? l:count : 1

    if l:char == s:keycode_escape
      if s:current_mode == 'o' | exe "normal! \<Esc>" | endif
      break
    endif

    if l:char == s:keycode_finish
      if s:current_mode == 'o' | exe "normal! \<Esc>gv" . s:operator | endif
      break
    endif

    if l:char == s:keycode_switch
      let s:is_reverse = !s:is_reverse
    endif

    if s:current_mode == 'v' || s:current_mode == 'o' | exe "normal! \<Esc>gv" | endif

    exe 'normal! ' . l:count . (!s:is_reverse ? 'f' : 'F') . nr2char(l:char)

    let l:is_first = 0
  endwhile

  call matchdelete(l:cursor_mark)
  call matchdelete(l:cursor_line)

endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
