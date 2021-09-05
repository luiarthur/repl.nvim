" Plugin: repl.vim
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
    \"py": "python3"
  \}

  " The third argument is the default value of the REPL to be executed (which
  " is nothing).
  let repl = get(repl_dict, ext, '')

  " Open terminal below and start REPL.
  exec "split | terminal " . repl

  " Go to bottom of REPL. This is needed to show the bottom (instead of the
  " top) of the REPL.
  normal! G

  " Send cursor back to window above.
  wincmd k
endfunction

" Sources a file into console below.
function! s:ReplSourceFile()
  let ext = expand("%:e")
  let filename = expand("%:p")
  let cmd = ""

  if ext == "R"
    let cmd = "source('" . filename . "')"
  elseif ext == "jl"
    let cmd = "include(\"" . filename . "\")"
  elseif ext == "scala"
    let cmd = ":load " . filename
  elseif ext == "py"
    let cmd = "exec(open('" . filename . "').read())"
  elseif ext == "sh"
    let cmd = "source " . filename
  elseif ext == "kt"
    let cmd = ":load  " . filename
  endif

  if cmd != ""
    exec "wincmd j"
    let @k = cmd . "\r"
    normal! "kp
    exec "wincmd p"
  else
    " %call s:ReplSendDown("line")
    " TODO:
    echo "No implementation for extention: ." . ext
  endif
endfunction

" Send text to another window.
function! s:ReplSendToWindow(type, direction)
  if a:type == "line"
    normal! yy
  else
    keepjumps normal! `<v`>y']
  endif

  execute "wincmd " . a:direction
  normal! gp
  let @k = "\r"
  normal! "kp
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

nmap <C-k> <Plug>ReplStartTermBelow<CR>
nmap <C-h> <Plug>ReplSourceFile<CR>

" NOTE: The g@ is confusing. See what happens when you do `g@ + j` in vi.
nnoremap <silent> <Plug>ReplSendDown :<C-U> call <SID>ReplSendDown('line')<CR>
nnoremap <silent> <Plug>ReplSendRight :<C-U> call <SID>ReplSendRight('line')<CR>
xnoremap <silent> <Plug>ReplSendDownV :<C-U> call <SID>ReplSendDown(visualmode())<CR>
xnoremap <silent> <Plug>ReplSendRightV :<C-U> call <SID>ReplSendRight(visualmode())<CR>

nmap <C-l> <Plug>ReplSendRight<CR>
xmap <C-l> <Plug>ReplSendRightV
nmap <C-j> <Plug>ReplSendDown<CR>
xmap <C-j> <Plug>ReplSendDownV
