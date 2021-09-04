# repl.vim
A basic REPL launcher for NeoVIM.

## Dependencies
- NeoVIM 0.5+

## Usage
1. Open a file in NeoVIM 0.5+
2. In `Normal` mode, type `Ctrl-p`. If the file extension is of a supported
   language (see below), then an appropriate REPL will be spawned. If the 
   language is not supported, or if you prefer a different REPL, open 
   a terminal in a vim split. I.e. using either `:split | term` (horizontal
   split) or `:vsplit | term` (vertical split). By default, if a language is not
   supported, `Ctrl-p` will execute `:split | term`.
3. Navigation (see below)

## Navigation

From a vim buffer (file), you can do the following in `Normal` mode.

Command                                          | Action
------------------------------------------------ | ----------------------------------------
`Ctrl-p`                                         | start REPL (see above)
`Ctrl-h` on a line                               | send current line to REPL on left
`Ctrl-j` on a line                               | send current line to REPL below
`Ctrl-k` on a line                               | send current line to REPL above
`Ctrl-l` on a line                               | send current line to REPL on right
`Ctrl-h` on a visual selection of multiple lines | send the selected lines to REPL on left
`Ctrl-j` on a visual selection of multiple lines | send the selected lines to REPL below
`Ctrl-k` on a visual selection of multiple lines | send the selected lines to REPL above
`Ctrl-l` on a visual selection of multiple lines | send the selected lines to REPL on right
`Ctrl-y` anywhere in file                        | source the file (language is supported)

Note that though the intended usage is for REPLs, you can actually send lines from the REPL back 
to the editors using the same commands. I.e., if you are in the REPL and do `Ctrl-j` at a line,
the line will be send to the buffer below. Also, note that the REPL (and buffers) will
be in `Normal` mode, but lines from the buffer will be executed in the REPLs.

## Supported Languages
- Julia (`*.jl`)
- Python (`*.py`)
- R (`*.R`)

## About
Inspired by [vim-sendtowindow][1].

[1]: https://github.com/karoliskoncevicius/vim-sendtowindow.
