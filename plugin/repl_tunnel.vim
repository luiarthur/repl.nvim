" Plugin: repl.vim/plugin/repl_tunnel.vim
" Author: Arthur Lui
" Dependencies: NeoVIM 0.5+

function! s:SendToWindow(type, direction)
  if a:type == "line"
    let @k = getline('.') . "\r"
    normal! j
    execute "wincmd " . a:direction
  else
    keepjumps normal! `<v`>y']
    execute "wincmd " . a:direction
    let @k = "\r"
    normal! gp
  endif

  normal! "kp

  " Return to previous window.
  wincmd p
endfunction

function! s:SendRight(type)
  call s:SendToWindow(a:type, 'l')
endfunction
function! s:SendLeft(type)
  call s:SendToWindow(a:type, 'h')
endfunction
function! s:SendUp(type)
  call s:SendToWindow(a:type, 'k')
endfunction
function! s:SendDown(type)
  call s:SendToWindow(a:type, 'j')
endfunction

nnoremap <silent> <Plug>SendDown  :<C-U> set operatorfunc=<SID>SendDown<CR>g@
nnoremap <silent> <Plug>SendRight :<C-U> set operatorfunc=<SID>SendRight<CR>g@
vnoremap <silent> <Plug>SendDownV  :<C-U> call <SID>SendDown(visualmode())<CR>
vnoremap <silent> <Plug>SendRightV :<C-U> call <SID>SendRight(visualmode())<CR>

nmap <C-l> <Plug>SendRight<CR>
xmap <C-l> <Plug>SendRightV
nmap <C-j> <Plug>SendDown<CR>
xmap <C-j> <Plug>SendDownV
