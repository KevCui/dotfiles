set nocompatible
colorscheme molokai
syntax on

" gvim font
set guifont=Hack\ 9

autocmd BufEnter * call DoWordComplete()
filetype plugin indent on
set nu
set hlsearch
set guicursor=a:blinkon0

" file coding utf-8
set encoding=utf-8
set fileencodings=utf-8
set termencoding=utf-8

" color
set t_Co=256

set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set fileformats=unix

set foldlevel=99

" spell check
autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us
autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_us
autocmd BufNewFile,BufRead *.markdown setlocal spell spelllang=en_us

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
call vundle#end()

" Switch j k key binding
nnoremap k j|xnoremap k j|onoremap k j|
nnoremap j k|xnoremap j k|onoremap j k|
