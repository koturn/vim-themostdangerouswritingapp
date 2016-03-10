" ============================================================================
" FILE: themostdangerouswritingapp.vim
" AUTHOR: koturn <jeak.koutan.apple@gmail.com>
" Last Modified: 2016 03/10
" DESCRIPTION: {{{
" The Most Dangerous Writing App in Vim
" }}}
" ============================================================================
if exists('g:loaded_themostdangerouswritingapp')
  finish
endif
let g:loaded_themostdangerouswritingapp = 1
let s:save_cpo = &cpo
set cpo&vim


command! -bar TheMostDangerousWritingAppEnable  call themostdangerouswritingapp#enable()
command! -bar TheMostDangerousWritingAppDisable  call themostdangerouswritingapp#disable()


let &cpo = s:save_cpo
unlet s:save_cpo
