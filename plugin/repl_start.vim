" Plugin: repl.vim/plugin/repl_start.vim
" Author: Arthur Lui
" Dependencies: NeoVIM 0.5+

" Starts a terminal (possibly with a REPL if extension is recognized), below
" the script.
function! StartTermBelow()
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
function! SourceFile()
  let ext = expand("%:e")
  let filename = expand("%:p")
  let cmd = ""

  if ext == "R"
    let cmd = "source('" . filename . "')"
  elseif ext == "jl"
    " NOTE: `includet` depends on Revise.jl. Uncomment this and comment the
    " next line to use this feature.
    " let cmd = "includet(\"" . filename . "\")"
    let cmd = "include(\"" . filename . "\")"
  elseif ext == "scala"
    let cmd = ":load " . filename
  elseif ext == "py"
    " python2
    "let cmd = "execfile('" . filename . "')"
    " python3
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
    " %call LineFeederNextLine()
  endif
endfunction

" ------------- Keyboard shortcuts. ---------------

" Use Ctrl-k to open terminal.
nnoremap <silent> <C-k> :call StartTermBelow()<CR>

" Use Ctrl-h to source a file, if possible.
nnoremap <silent> <C-h> :call SourceFile()<cr>
