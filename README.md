# repl.vim
A basic REPL launcher for NeoVIM.

## Dependencies
- NeoVIM 0.5+

## Usage
1. Open a file in NeoVIM 0.5+
2. In `Normal` mode, type `Ctrl-k`. If the file extension is of a supported
   language (see below), then an appropriate REPL will be spawned. If the 
   language is not supported, or if you prefer a different REPL, open 
   a terminal in a vim split. I.e. using either `:split | term` (horizontal
   split) or `:vsplit | term` (vertical split). By default, if a language is not
   supported, `Ctrl-k` will execute `:split | term`.
3. Navigation (see below)

## Navigation

From a vim buffer (file), you can do the following in `Normal` mode.

Command                                          | Action
------------------------------------------------ | ----------------------------------------
`Ctrl-k`                                         | start REPL (see above)
`Ctrl-h` anywhere in file                        | source the file (language is supported)
`Ctrl-j` on a line                               | send current line to REPL below
`Ctrl-l` on a line                               | send current line to REPL on right
`Ctrl-j` on a visual selection of multiple lines | send the selected lines to REPL below
`Ctrl-l` on a visual selection of multiple lines | send the selected lines to REPL on right

Note that the REPL (and buffers) will be in `Normal` mode, but lines from the
buffer will be executed in the REPLs.

## Supported Languages
- Julia (`*.jl`)
- Python (`*.py`)
- R (`*.R`)

## About
Inspired by [vim-sendtowindow][1].

[1]: https://github.com/karoliskoncevicius/vim-sendtowindow.
