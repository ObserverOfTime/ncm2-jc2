"=============================================================================
" FILE: ncm2_jc2.vim
" AUTHOR:  Observer of Time <chronobserver@disroot.org>
" License: MIT license
"=============================================================================

if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1

function! ncm2_jc2#on_complete(ctx) abort
  let base = a:ctx['base']
  let start = javacomplete#complete#complete#Complete(1, base, 0)
  if getline(line('.') - 1) =~? '^\s*@Override\s*$'
    let matches = javacomplete#complete#complete#CompleteAfterOverride()
  else
    let matches = javacomplete#complete#complete#Complete(0, base, 1)
  endif
  call ncm2#complete(a:ctx, start + 1, matches)
endfunction

function! ncm2_jc2#init() abort
  call  ncm2#register_source({
        \ 'name': 'javacomplete2',
        \ 'mark': 'jc2',
        \ 'priority': 9,
        \ 'word_pattern': '[@\w_]+',
        \ 'complete_pattern': ['->\s*', '::', '\.',
        \                      '@Override\n\s*'],
        \ 'scope': ['java', 'jsp'],
        \ 'on_complete': 'ncm2_jc2#on_complete',
        \ })
endfunction

" vim:set et sw=2 ts=2:

