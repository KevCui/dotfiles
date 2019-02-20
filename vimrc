" plugins
call plug#begin('~/.vim/plugged')
Plug 'godlygeek/tabular' "align text
Plug 'plasticboy/vim-markdown' "markdown highlight
Plug 'wellle/targets.vim' "di'
Plug 'cespare/vim-toml' "toml syntax
Plug 'elzr/vim-json' "json syntax
Plug 'tpope/vim-fugitive' "Gedit Gstatus Gdiff
Plug 'easymotion/vim-easymotion' "w f b s
Plug 'ervandew/supertab' "tab completion
Plug 'raimondi/delimitmate' "auto close quote
Plug 'scrooloose/nerdcommenter' "ci cm cu
Plug 'kshenoy/vim-signature' "mx dmx m<space> m. m,
Plug 'SirVer/ultisnips' "UltiSnips
Plug 'honza/vim-snippets' "snippets files
Plug 'RRethy/vim-illuminate' "illuminating select
Plug 'itchyny/lightline.vim' "status line
Plug 'junegunn/goyo.vim' "free writing
Plug 'godlygeek/csapprox' "gui color for term
Plug 'lilydjwg/colorizer' "colorize all color texts
Plug 'jamessan/vim-gnupg' "gpg encryption
Plug 'blindFS/vim-taskwarrior' "taskwarrior :TW
Plug 'tpope/vim-surround' "cs ds ysiw
Plug 'w0rp/ale' "synchronous Lint Engine
Plug 'posva/vim-vue' "syntax for Vue.js components
Plug 'udalov/kotlin-vim' "syntax for Kotlin
Plug 'keith/swift.vim' "syntax for swift
Plug 'zchee/deoplete-jedi' "deoplete for python
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' } "deoplete for js
Plug 'mhinz/vim-signify' "show changes
Plug 'Alok/notational-fzf-vim' "Notational FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "fzf
Plug 'junegunn/fzf.vim' "fzf.vim

" nvim or vim?
if has('nvim')
    " Escape terminal
    tnoremap <Esc> <C-\><C-n>

    " w!! write file with sudo
    Plug 'lambdalisue/suda.vim' "read write with sudo
    cnoremap w!! execute 'write suda://%'

    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    " encryption
    setlocal cryptmethod=blowfish2

    " w!! write file with sudo
    cnoremap w!! execute 'write !sudo tee % >/dev/null' <bar> edit!

    Plug 'roxma/nvim-yarp'
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

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
set mouse+=a

" line number
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" spell check
augroup vimrc
    autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us
    autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_us
    autocmd BufNewFile,BufRead *.markdown setlocal spell spelllang=en_us
augroup END

" leader key mapping
let mapleader = ' '

" maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

" Switch j k key bindings
set langmap=jk,kj

" Clear search highlight
nmap <silent> ,/ :nohlsearch<CR>

" System clipboard
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d

" tab
imap <expr><TAB>
\ neosnippet#expandable_or_jumpable() ? :
\   "\<Plug>(neosnippet_expand_or_jump)" :
\ pumvisible()? "\<C-y>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ deoplete#mappings#manual_complete()

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

" gpg
let g:GPGUseAgent=1
let g:GPGPreferSymmetric=1
let g:GPGPreferArmor=1
let g:GPGUsePipes=1

" netrw :Vex
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" ale linters
nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)
let b:ale_linters = {
\   'bash': ['shellcheck'],
\   'css': ['stylelint'],
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\   'vim': ['vint']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'css': ['prettier'],
\   'javascript': ['eslint'],
\   'python': ['autopep8'],
\   'yaml': ['prettier'],
\}

let g:ale_fix_on_save = 1

" vim-illuminate
hi illuminatedWord ctermbg=238

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" deoplete
let g:deoplete#enable_at_startup = 1

" turn off previewwindow
set completeopt-=preview

" syntax folding
setlocal foldmethod=syntax

" notational-fzf-vim
nnoremap <silent> <c-f> :NV<CR>
let g:nv_create_note_key = 'ctrl-x'
let g:nv_default_extension = '.md'
let g:nv_search_paths = ['~/SparkleShare', '~/Notes', './content/post', './doc', './README.md', './TODO.md']
let g:nv_keymap = {
\ 'ctrl-s': 'split ',
\ 'ctrl-b': 'vertical split ',
\ 'ctrl-t': 'tabedit ',
\ }
