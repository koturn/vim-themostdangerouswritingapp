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
  augroup TheMostDangerousWritingApp
    autocmd!
    autocmd CursorMoved,CursorMovedI <buffer>  let s:clock = 0
    autocmd CursorHold,CursorHoldI <buffer>  call s:update()
  augroup END
endfunction

function! themostdangerouswritingapp#disable() abort
  augroup TheMostDangerousWritingApp
    autocmd! CursorHold,CursorHoldI <buffer>
    let s:clock = 0
  augroup END
endfunction


let s:clock = 0
function! s:update() abort
  if s:clock < g:themostdangerouswritingapp#time_to_stop
    call feedkeys(mode() ==# 'i' ? "\<C-g>\<ESC>" : "g\<ESC>", 'n')
    let s:clock += &updatetime
  else
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
