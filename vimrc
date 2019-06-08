" plugins
call plug#begin('~/.vim/plugged')
Plug 'godlygeek/tabular' "align text :Tab /=
Plug 'tpope/vim-fugitive' "Gedit Gstatus Gdiff
Plug 'raimondi/delimitmate' "auto close quote
Plug 'honza/vim-snippets' "snippets files
Plug 'jamessan/vim-gnupg' "gpg encryption
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'Alok/notational-fzf-vim' "Notational FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "fzf
Plug 'junegunn/fzf.vim' "fzf.vim
Plug 'rbong/vim-flog' "Git branch viewer :Flog
Plug 'mbbill/undotree' "Undo history visualizer
Plug 'makerj/vim-pdf' "read PDF
"   syntax
Plug 'w0rp/ale' "synchronous Lint Engine
Plug 'posva/vim-vue' "syntax for Vue.js components
Plug 'udalov/kotlin-vim' "syntax for Kotlin
Plug 'keith/swift.vim' "syntax for swift
Plug 'cespare/vim-toml' "syntax for toml
Plug 'elzr/vim-json' "syntax for json
"   navigation
Plug 'scrooloose/nerdcommenter' "ci cm cu
Plug 'kshenoy/vim-signature' "mx dmx m<space> m. m,
Plug 'tpope/vim-surround' "cs ds ysiw
Plug 'wellle/targets.vim' "di'
Plug 'easymotion/vim-easymotion' "w f b s
Plug 'machakann/vim-swap' "swap item g> g< gs
"   theme
Plug 'arcticicestudio/nord-vim' "Nord theme
Plug 'mhinz/vim-signify' "show changes
Plug 'Yggdroot/indentLine' "display indention levels
Plug 'RRethy/vim-hexokinase' "display color label
Plug 'RRethy/vim-illuminate' "illuminating select
Plug 'itchyny/lightline.vim' "status line

" nvim or vim?
if has('nvim')
    " Escape terminal
    tnoremap <Esc> <C-\><C-n>
    autocmd BufWinEnter,WinEnter term://* set norelativenumber nonumber | startinsert
    autocmd BufLeave term://* stopinsert

    " w!! write file with sudo
    Plug 'lambdalisue/suda.vim' "read write with sudo
    cnoremap w!! execute 'write suda://%'
    nnoremap <C-t> :tabe term://zsh<CR>

    " highlight in :s
    set inccommand=nosplit
else
    " encryption
    setlocal cryptmethod=blowfish2

    " w!! write file with sudo
    cnoremap w!! execute 'write !sudo tee % >/dev/null' <bar> edit!

    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

" theme & color
set termguicolors
set t_Co=256
set laststatus=2
filetype plugin indent on
filetype plugin on
set hlsearch
set guicursor=a:blinkon0
syntax on
"   nord theme
let g:nord_italic = 0
let g:nord_underline = 1
let g:nord_italic_comments = 1
let g:nord_uniform_status_lines = 1
let g:nord_uniform_diff_background = 1
colorscheme nord
"   gvim font
set guifont=Hack\ 9

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

" settings
set nomodeline
set ignorecase
set smartcase
set lazyredraw

" line number
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufEnter,FocusGained,InsertLeave term://* set norelativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" spell check
augroup vimrc
  autocmd!
  autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us
  autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_us
  autocmd BufNewFile,BufRead *.markdown setlocal spell spelllang=en_us
augroup END
set spellfile=~/.vim/spell/en.utf-8.add

" grammar check
let g:grammarous#languagetool_cmd = 'languagetool'

" maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

" key mapping
let mapleader = ' '
"   swap current char with next char
nnoremap <silent> gc xph
"   swap current char with previous char
nnoremap <silent> gC Xp
"   switch j k key bindings
set langmap=jk,kj
"   clear search highlight
nmap <silent> ,/ :nohlsearch<CR>
"   system clipboard
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d
"   easymotion
map <Leader> <Plug>(easymotion-prefix)

" nerdcommenter
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not

" mark highlight color
hi SignatureMarkText guifg=Green guibg=#212121
hi SignColumn guibg=#212121

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
let g:ale_python_autopep8_options = '--max-line-length 256'

let g:ale_fix_on_save = 1

" vim-illuminate
hi illuminatedWord ctermbg=238 guibg=#3a3a3a

" turn off previewwindow
set completeopt-=preview

" syntax folding
setlocal foldmethod=syntax

" notational-fzf-vim
nnoremap <silent> <c-f> :NV<CR>
let g:nv_create_note_key = 'ctrl-x'
let g:nv_default_extension = '.md'
let g:nv_search_paths = ['~/Notes', './content/post', './doc', './README.md', './TODO.md']
let g:nv_ignore_pattern = ['.git']
let g:nv_keymap = {
\ 'ctrl-s': 'split ',
\ 'ctrl-b': 'vertical split ',
\ 'ctrl-t': 'tabedit ',
\ }

" coc use compiled code
let g:coc_force_debug = 1

" coc tab keybinding
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" coc snippets
autocmd FileType json syntax match Comment +\/\/.\+$+
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status'
  \ },
\ }

" undotree
nnoremap <F5> :UndotreeToggle<CR>

" enable hexokinase color label
let g:Hexokinase_ftAutoload = ['css', 'xml', 'md']

" vim-json & indentLine syntax conceal
let g:vim_json_syntax_conceal = 0
