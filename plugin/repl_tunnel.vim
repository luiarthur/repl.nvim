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

nnoremap <silent> <Plug>SendUp    :<C-U> set operatorfunc=<SID>SendUp<CR>g@
nnoremap <silent> <Plug>SendDown  :<C-U> set operatorfunc=<SID>SendDown<CR>g@
nnoremap <silent> <Plug>SendRight :<C-U> set operatorfunc=<SID>SendRight<CR>g@
nnoremap <silent> <Plug>SendLeft  :<C-U> set operatorfunc=<SID>SendLeft<CR>g@

vnoremap <silent> <Plug>SendUpV    :<C-U> call <SID>SendUp(visualmode())<CR>
vnoremap <silent> <Plug>SendDownV  :<C-U> call <SID>SendDown(visualmode())<CR>
vnoremap <silent> <Plug>SendRightV :<C-U> call <SID>SendRight(visualmode())<CR>
vnoremap <silent> <Plug>SendLeftV  :<C-U> call <SID>SendLeft(visualmode())<CR>

nmap <C-l> <Plug>SendRight<CR>
xmap <C-l> <Plug>SendRightV
nmap <C-h> <Plug>SendLeft<CR>
xmap <C-h> <Plug>SendLeftV
nmap <C-k> <Plug>SendUp<CR>
xmap <C-k> <Plug>SendUpV
nmap <C-j> <Plug>SendDown<CR>
xmap <C-j> <Plug>SendDownV
