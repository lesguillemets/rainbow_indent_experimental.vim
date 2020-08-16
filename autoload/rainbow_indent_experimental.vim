let s:cpo_backup = &cpo
set cpo&vim

function! rainbow_indent_experimental#prepare()
  hi RainbowIndentLevel1 guibg=#2c3911
  hi RainbowIndentLevel2 guibg=#11392c
  hi RainbowIndentLevel3 guibg=#111139
  hi RainbowIndentLevel4 guibg=#39112c
endfunction

function! rainbow_indent_experimental#init_color()
  if &expandtab
    let l:indentation = repeat(' ', &sw)
  else
    let l:indentation = '\t'
  endif
  for level in range(1,4)
    call matchadd('RainbowIndentLevel' . level , '^\zs' . repeat(l:indentation, level)  .  '\ze\(\S\|$\)')
  endfor
endfunction

let &cpo = s:cpo_backup
unlet s:cpo_backup

" vim: expandtab ts=2 sts=2 sw=2
