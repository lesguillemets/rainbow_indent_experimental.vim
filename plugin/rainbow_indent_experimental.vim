if exists('g:loaded_rainbow_indent_experimental')
  finish
endif
let s:cpo_backup = &cpo
set cpo&vim

augroup Rainbow_Indent_Experimental
  autocmd!
  autocmd ColorScheme * call rainbow_indent_experimental#prepare()

  autocmd Filetype * call rainbow_indent_experimental#init_color()
  autocmd VimEnter * call rainbow_indent_experimental#init_color()
  autocmd OptionSet shiftwidth call rainbow_indent_experimental#init_color()
augroup END
let g:loaded_rainbow_indent_experimental=1

let &cpo = s:cpo_backup
unlet s:cpo_backup
" vim: expandtab ts=2 sts=2 sw=2
