set nocompatible
colorscheme snazzy
syntax on

" gvim font
set guifont=Hack\ 9

filetype plugin indent on
filetype plugin on
set nu
set hlsearch
set guicursor=a:blinkon0

"file coding utf-8
set encoding=utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8

" color
set t_Co=256

" format
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

" leader key mapping
let mapleader = " "

" plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'godlygeek/tabular' "align text                https://github.com/godlygeek/tabular
Plugin 'plasticboy/vim-markdown' "markdown highlight  https://github.com/plasticboy/vim-markdown
Plugin 'wellle/targets.vim' "di'                      https://github.com/wellle/targets.vim
Plugin 'cespare/vim-toml' "toml syntax                https://github.com/cespare/vim-toml
Plugin 'elzr/vim-json' "json syntax                   https://github.com/elzr/vim-json
Plugin 'tpope/vim-fugitive' "Gedit Gstatus Gdiff      https://github.com/tpope/vim-fugitive
Plugin 'scrooloose/nerdtree' "file system             https://github.com/scrooloose/nerdtree
Plugin 'easymotion/vim-easymotion' "w f b s           https://github.com/easymotion/vim-easymotion
Plugin 'ervandew/supertab' "tab completion            https://github.com/ervandew/supertab
Plugin 'raimondi/delimitmate' "auto close quote       https://github.com/raimondi/delimitmate
Plugin 'scrooloose/nerdcommenter' "ci cm cu           https://github.com/scrooloose/nerdcommenter
Plugin 'kshenoy/vim-signature' "mx dmx m<space> m. m, https://github.com/kshenoy/vim-signature
Plugin 'SearchComplete' "insert mode completion       https://github.com/vim-scripts/SearchComplete
Plugin 'honza/vim-snippets'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
call vundle#end()

" Switch j k key bindings
nnoremap k j|xnoremap k j|onoremap k j|
nnoremap j k|xnoremap j k|onoremap j k|

" System clipboard
:inoremap <C-v> <ESC>"+pa
:vnoremap <C-c> "+y
:vnoremap <C-d> "+d

" Grammar check
let g:grammarous#languagetool_cmd = 'languagetool'

" Markdown syntax hightlighting
set conceallevel=2

" Easymotion
map <Leader> <Plug>(easymotion-prefix)

" Front Matter
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

" nerdcommenter
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not


" Mark highlight color
hi SignatureMarkText guifg=Green guibg=#1E1E1E
hi SignColumn guibg=#1E1E1E
