# repl.nvim
A basic REPL launcher for NeoVIM.

## Dependencies
- NeoVIM 0.5+

# Installation
If using the plugin manager `plug.vim` add `Plug luiarthur/repl.nvim` to the
correct location. Similar for other vim plugin managers. If not using a plugin
manager, just copy `plugin/repl.nvim` to `~/.vim/plugin/` (for vim users). If
using neovim, a plugin manager is recommended.

## Usage
1. Open a file in NeoVIM 0.5+
2. In `Normal` mode, type `Ctrl-k`. If the file extension is of a supported
   language (see below), then an appropriate REPL will be spawned. If the
   language is not supported, or if you prefer a different REPL, open a
   terminal in a vim split. I.e. using either `:split | term` (horizontal
   split) or `:vsplit | term` (vertical split). By default, if a language is
   not supported, `Ctrl-k` will execute `:split | term`.
3. Navigation (see below)

## Navigation

From a vim buffer (file), you can do the following in `Normal` mode.

Action                                   | Command
---------------------------------------- |------------------------------------------------ 
Start REPL (see above)                   |`Ctrl-k`
Source the file (language is supported)  |`Ctrl-h` anywhere in file
Send current line to REPL below          |`Ctrl-j` on a line
Send current line to REPL on right       |`Ctrl-l` on a line
Send the selected lines to REPL below    |`Ctrl-j` on a visual selection of multiple lines 
Send the selected lines to REPL on right |`Ctrl-l` on a visual selection of multiple lines 

Note that the REPL (and buffers) will be in `Normal` mode, but lines from the
buffer will be executed in the REPLs.

The default key-bindings can be remapped. For example, the default bindings are
defined as follows:

Action                                   | Default key-binding
---------------------------------------- |------------------------------------------------ 
Start REPL                               | `nmap <C-k> <Plug>ReplStartTermBelow<CR>`
Source the file                          | `nmap <C-h> <Plug>ReplSourceFile<CR>`
Send current line to REPL below          | `nmap <C-j> <Plug>ReplSendDown<CR>`
Send current line to REPL on right       | `nmap <C-l> <Plug>ReplSendRight<CR>`
Send the selected lines to REPL below    | `xmap <C-j> <Plug>ReplSendDownV`
Send the selected lines to REPL on right | `xmap <C-l> <Plug>ReplSendRightV`

Default key bindings will be used if either `let g:repl_default_key_bindings = 1`
is invoked in `init.vim` OR `g:repl_default_key_bindings` is not defined.

## Supported Languages
- Julia (`*.jl`)
- Python (`*.py`)
- R (`*.R`)

## About
Inspired by [vim-sendtowindow][1].

[1]: https://github.com/karoliskoncevicius/vim-sendtowindow.
