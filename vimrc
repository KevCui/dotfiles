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
Plugin 'SirVer/ultisnips' "UltiSnips                  https://github.com/SirVer/ultisnips
Plugin 'honza/vim-snippets' "snippets files           https://github.com/honza/vim-snippets
Plugin 'RRethy/vim-illuminate' "illuminating select   https://github.com/RRethy/vim-illuminate
Plugin 'itchyny/lightline.vim' "status line           https://github.com/itchyny/lightline.vim
Plugin 'junegunn/goyo.vim' "free writing              https://github.com/junegunn/goyo.vim
Plugin 'godlygeek/csapprox' "gui color for term       https://github.com/godlygeek/csapprox
Plugin 'lilydjwg/colorizer' "colorize all color texts https://github.com/lilydjwg/colorizer
Plugin 'jamessan/vim-gnupg' "gpg encryption           https://github.com/jamessan/vim-gnupg
call vundle#end()

" theme & color
set t_Co=256
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
colorscheme iceberg
set laststatus=2
let g:lightline = { 'colorscheme': 'iceberg'  }

" gvim font
set guifont=Hack\ 9

filetype plugin indent on
filetype plugin on
set nu
set hlsearch
set guicursor=a:blinkon0
syntax on

" file coding utf-8
set encoding=utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set nofixendofline

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

" maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

" Switch j k key bindings
nnoremap k j|xnoremap k j|onoremap k j|
nnoremap j k|xnoremap j k|onoremap j k|

" System clipboard
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d

" Grammar check
let g:grammarous#languagetool_cmd = 'languagetool'

" Markdown syntax hightlighting
set conceallevel=2

" Easymotion
map <Leader> <Plug>(easymotion-prefix)

" Front Matter
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

" markdown folding
let g:vim_markdown_folding_disabled = 1

" nerdcommenter
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not

" Mark highlight color
hi SignatureMarkText guifg=Green guibg=#1E1E1E
hi SignColumn guibg=#1E1E1E

" Disable illuminate for nerdtree
let g:Illuminate_ftblacklist = ['nerdtree']

" gpg
let g:GPGUseAgent=1
let g:GPGPreferSymmetric=1
let g:GPGPreferArmor=1
let g:GPGUsePipes=1

if has('nvim')
    " Escape terminal
    tnoremap <Esc> <C-\><C-n>

    " w!! write file with sudo
    Plugin 'lambdalisue/suda.vim' "read write with sudo   https://github.com/lambdalisue/suda.vim
    cnoremap w!! execute 'write suda://%'
else
    " encryption
    setlocal cm=blowfish2

    " w!! write file with sudo
    cnoremap w!! execute 'write !sudo tee % >/dev/null' <bar> edit!
endif
