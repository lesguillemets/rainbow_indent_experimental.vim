let s:cpo_backup = &cpo
set cpo&vim

function! rainbow_indent_experimental#prepare()
  let s:indent_colors = get(g:, 'rainbow_indent_experimental_colors',
        \  [ '#2c3911', '#11392c', '#111139', '#39112c'])
  let s:max_levels = len(s:indent_colors)
  for i in range(s:max_levels)
    execute 'hi RainbowIndentLevel' . (i+1) . ' guibg=' . s:indent_colors[i]
  endfor
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
