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
    autocmd CursorHold,CursorHoldI * call s:update()
  augroup END
endfunction

function! themostdangerouswritingapp#disable() abort
  augroup TheMostDangerousWritingApp
    autocmd!
  augroup END
endfunction


let s:clock = 0
function! s:update() abort
  if s:clock < g:themostdangerouswritingapp#time_to_stop
    call feedkeys(mode() ==# 'i' ? "\<C-g>\<ESC>" : "g\<ESC>", 'n')
    let s:clock += &updatetime
  else
    call feedkeys("\<Esc>ggdG", 'n')
    write
    bwipeout
    call themostdangerouswritingapp#disable()
  endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo