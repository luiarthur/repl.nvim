# repl.vim
A basic REPL launcher for NeoVIM.

## Dependencies
- NeoVIM 0.5+

## Usage
1. Open a file in NeoVIM 0.5+
2. In Normal mode, type `Ctrl-w + p`. If the file extension is of a supported
   language (see below), then an appropriate REPL will be spawned. If the 
   language is not supported, or if you prefer a different REPL, open 
   a terminal in a vim split. I.e. using either `:split | term` (horizontal
   split) or `:vsplit | term` (vertical split).
3. Navigation (see below)

## Navigation
TODO

## Supported Languages
- Julia (`*.jl`)
- Python (`*.py`)
- R (`*.R`)

## About
Inspired by [vim-sendtowindow][1].

[1]: https://github.com/karoliskoncevicius/vim-sendtowindow.
