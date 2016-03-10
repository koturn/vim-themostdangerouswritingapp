" ============================================================================
" FILE: themostdangerouswritingapp.vim
" AUTHOR: koturn <jeak.koutan.apple@gmail.com>
" Last Modified: 2016 03/10
" DESCRIPTION: {{{
" The Most Dangerous Writing App in Vim
" }}}
" ============================================================================
let s:save_cpo = &cpo
set cpo&vim

let g:themostdangerouswritingapp#time_to_stop = get(g:, 'themostdangerouswritingapp#time_to_stop', 5000)


function! themostdangerouswritingapp#enable() abort
  let b:themostdangerouswritingapp_clock = 0
  augroup TheMostDangerousWritingApp
    autocmd!
    autocmd CursorMoved,CursorMovedI <buffer>  let b:themostdangerouswritingapp_clock = 0
    autocmd CursorHold,CursorHoldI <buffer>  call s:update()
  augroup END
endfunction

function! themostdangerouswritingapp#disable() abort
  augroup TheMostDangerousWritingApp
    autocmd! CursorHold,CursorHoldI,CursorMoved,CursorMovedI <buffer>
  augroup END
endfunction


function! s:update() abort
  if b:themostdangerouswritingapp_clock < g:themostdangerouswritingapp#time_to_stop
    call feedkeys(mode() ==# 'i' ? "\<C-g>\<ESC>" : "g\<ESC>", 'n')
    let b:themostdangerouswritingapp_clock += &updatetime
  else
    unlet! b:themostdangerouswritingapp_clock
    execute 'normal! ggdG'
    let save_undolevels = &l:undolevels
    setlocal undolevels=-1
    execute "normal! a \<BS>\<Esc>"
    setlocal nomodified
    let &l:undolevels = save_undolevels
    write
    call themostdangerouswritingapp#disable()
  endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
