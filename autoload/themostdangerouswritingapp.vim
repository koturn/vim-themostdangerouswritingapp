" ============================================================================
" FILE: themostdangerouswritingapp.vim
" AUTHOR: koturn <jeak.koutan.apple@gmail.com>
" Last Modified: 2016 04/24
" DESCRIPTION: {{{
" The Most Dangerous Writing App in Vim
" }}}
" ============================================================================
let s:save_cpo = &cpo
set cpo&vim

let g:themostdangerouswritingapp#time_to_stop = get(g:, 'themostdangerouswritingapp#time_to_stop', 5000)


if has('timers')
  let s:timer_id = 0

  function! themostdangerouswritingapp#enable() abort
    call themostdangerouswritingapp#disable()
    augroup TheMostDangerousWritingApp
      autocmd CursorMoved,CursorMovedI <buffer>  call timer_stop(s:timer_id)
      autocmd CursorHold,CursorHoldI <buffer>  let s:timer_id = timer_start(g:themostdangerouswritingapp#time_to_stop, function('s:callback'))
    augroup END
  endfunction

  function! themostdangerouswritingapp#disable() abort
    call timer_stop(s:timer_id)
    augroup TheMostDangerousWritingApp
      autocmd! CursorHold,CursorHoldI,CursorMoved,CursorMovedI <buffer>
    augroup END
  endfunction

  function! s:callback(timer_id) abort
    call s:clean_buffer_text()
  endfunction
else
  function! themostdangerouswritingapp#enable() abort
    call themostdangerouswritingapp#disable()
    augroup TheMostDangerousWritingApp
      autocmd CursorMoved,CursorMovedI <buffer>  let b:themostdangerouswritingapp_clock = 0
      autocmd CursorHold,CursorHoldI <buffer>  call s:update()
    augroup END
    let b:themostdangerouswritingapp_clock = 0
  endfunction

  function! themostdangerouswritingapp#disable() abort
    unlet! b:themostdangerouswritingapp_clock
    augroup TheMostDangerousWritingApp
      autocmd! CursorHold,CursorHoldI,CursorMoved,CursorMovedI <buffer>
    augroup END
  endfunction

  function! s:update() abort
    if b:themostdangerouswritingapp_clock < g:themostdangerouswritingapp#time_to_stop
      call feedkeys(mode() ==# 'i' ? "\<C-g>\<ESC>" : "g\<ESC>", 'n')
      let b:themostdangerouswritingapp_clock += &updatetime
    else
      call s:clean_buffer_text()
      call themostdangerouswritingapp#disable()
    endif
  endfunction
endif


function! s:clean_buffer_text() abort
  execute 'normal! ggdG'
  let save_undolevels = &l:undolevels
  setlocal undolevels=-1
  execute "normal! a \<BS>\<Esc>"
  setlocal nomodified
  let &l:undolevels = save_undolevels
  silent! write
  call themostdangerouswritingapp#disable()
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
