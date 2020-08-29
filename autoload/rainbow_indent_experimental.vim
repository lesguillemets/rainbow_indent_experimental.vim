let s:cpo_backup = &cpo
set cpo&vim

function! rainbow_indent_experimental#init()
  let s:rainbow_indent_experimental_default_on =
        \ get(g:,'rainbow_indent_experimental_default_on', 1)
  let s:rainbow_indent_experimental_filetypes_off =
        \ get(g:, 'rainbow_indent_experimental_filetypes_off',
        \ ['help'])
  let s:rainbow_indent_experimental_filetypes_on =
        \ get(g:, 'rainbow_indent_experimental_filetypes_on', [])
endfunction

function! rainbow_indent_experimental#prepare()
  let s:indent_colors = get(g:, 'rainbow_indent_experimental_colors',
        \  [ '#2c3911', '#11392c', '#111139', '#2c1139', '#39112c'])
  let s:indent_colors_fg = get(g:,'rainbow_indent_experimental_colors_fg',
        \ [ '#0f0f0f' ])
  let s:max_levels = len(s:indent_colors)
  let s:fg_len = len(s:indent_colors_fg)
  for i in range(s:max_levels)
    execute 'hi RainbowIndentLevel' . (i+1) . ' guibg=' . s:indent_colors[i] . ' guifg=' . s:indent_colors_fg[i % s:fg_len]
  endfor
endfunction

function! rainbow_indent_experimental#init_color()
  for match_id in get(w:, 'rainbow_indent_experimental_matches', [])
    " remove matches that will be duplicate
    call matchdelete(match_id)
  endfor
  let w:rainbow_indent_experimental_matches = []

  if s:rainbow_indent_experimental_default_on
    if index(s:rainbow_indent_experimental_filetypes_off, &ft) >= 0
      " verbose but less confusing?
      return
    endif
  else " when defaults to off
    if index(s:rainbow_indent_experimental_filetypes_on, &ft) < 0
      return
    endif
  endif

  if &expandtab
    let l:indentation = repeat(' ', &sw)
  else
    let l:indentation = '\t'
  endif
  call add(w:rainbow_indent_experimental_matches,
  \ matchadd(
  \ 'RainbowIndentLevel1',
  \ '^\zs' . l:indentation
  \ ))
  for level in range(2,s:max_levels)
    call add(w:rainbow_indent_experimental_matches,
    \ matchadd(
    \ 'RainbowIndentLevel' . level ,
    \ '^' . repeat(l:indentation, level-1)  .  '\zs' . l:indentation . '\ze'
    \ ))
  endfor
endfunction

let &cpo = s:cpo_backup
unlet s:cpo_backup

" vim: expandtab ts=2 sts=2 sw=2
