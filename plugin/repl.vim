" Plugin: repl.nvim
" Author: Arthur Lui
" Dependencies: NeoVIM 0.5+

" Starts a terminal (possibly with a REPL if extension is recognized), below
" the script.
function! s:ReplStartTermBelow()
  " Get file extension
  let ext = expand("%:e")

  " Dictionary of program REPLs, with file extensions as keys.
  let repl_dict = {
    \"R": "R",
    \"jl": "julia",
    \"py": "ipython --no-autoindent"
  \}

  " The third argument is the default value of the REPL to be executed (which
  " is nothing).
  let repl = get(repl_dict, ext, '')

  " Open terminal below and start REPL.
  exec "split | terminal " . repl

  " Go to bottom of REPL. This is needed to show the bottom (instead of the
  " top) of the REPL.
  normal! G

  " Send cursor back to previous window.
  wincmd p
endfunction

" Sources a file into console below.
function! s:ReplSourceFile()
  let ext = expand("%:e")
  let filename = expand("%:p")
  let cmd = get({
    \'R': 'source("' . filename . '")',
    \'jl': 'include("' . filename . '")',
    \'py': 'exec(open("' . filename . '").read())',
    \'sh': 'source ' . filename,
    \'kt': 'load: ' . filename,
    \'scala': 'load: ' . filename
  \}, ext, '')

  if cmd == ""
    let lineByLine = confirm("No kernel for `." . ext . "`. Run line by line?",  "&Yes\n&No")
    if lineByLine == 1
      %call s:ReplSendDown("line")
    endif
  else
    wincmd j
    call chansend(b:terminal_job_id, cmd . "\r")
    wincmd p
  endif
endfunction

" Send text to another window.
function! s:ReplSendToWindow(type, direction)
  if a:type == "line"
    normal! yy
  else
    keepjumps normal! `<v`>y']
  endif

  exec "wincmd " . a:direction
  call chansend(b:terminal_job_id, @" . "\r")
  wincmd p
endfunction

" Send text the window on the right.
function! s:ReplSendRight(type)
  call s:ReplSendToWindow(a:type, 'l')
endfunction

" Send text the window below.
function! s:ReplSendDown(type)
  call s:ReplSendToWindow(a:type, 'j')
endfunction

" ------------------------ Maps --------------------------------------------
nnoremap <silent> <Plug>ReplStartTermBelow :<C-U> call <SID>ReplStartTermBelow()<CR>
nnoremap <silent> <Plug>ReplSourceFile :<C-U> call <SID>ReplSourceFile()<CR>
nnoremap <silent> <Plug>ReplSendDown :<C-U> call <SID>ReplSendDown('line')<CR>
nnoremap <silent> <Plug>ReplSendRight :<C-U> call <SID>ReplSendRight('line')<CR>
xnoremap <silent> <Plug>ReplSendDownV :<C-U> call <SID>ReplSendDown(visualmode())<CR>
xnoremap <silent> <Plug>ReplSendRightV :<C-U> call <SID>ReplSendRight(visualmode())<CR>

" The following default key bindings will be used if `repl_default_bindings`
" is not defined OR `let g:repl_default_bindings = 1` is set in `init.vim`.
if !exists("g:repl_default_bindings") || g:repl_default_bindings
  nmap <C-k> <Plug>ReplStartTermBelow<CR>
  nmap <C-h> <Plug>ReplSourceFile<CR>
  nmap <C-l> <Plug>ReplSendRight<CR>
  xmap <C-l> <Plug>ReplSendRightV
  nmap <C-j> <Plug>ReplSendDown<CR>
  xmap <C-j> <Plug>ReplSendDownV
endif
