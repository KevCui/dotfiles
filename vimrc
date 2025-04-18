" -------
" PLUGINS
" -------
call plug#begin('~/.vim/plugged')
Plug 'godlygeek/tabular' "align text :Tabularize /=
Plug 'raimondi/delimitmate' "auto close quote
Plug 'jamessan/vim-gnupg' "gpg encryption
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Alok/notational-fzf-vim' "Notational FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "fzf
Plug 'junegunn/fzf.vim' "fzf.vim
Plug 'mbbill/undotree' "Undo history visualizer
Plug 'gyim/vim-boxdraw' "+o, +O, +-, +>, +|
"   syntax
Plug 'w0rp/ale' "synchronous Lint Engine
"   navigation
Plug 'scrooloose/nerdcommenter' "ci cm cu
Plug 'kshenoy/vim-signature' "mx dmx m<space> m. m,
Plug 'easymotion/vim-easymotion' "w s
Plug 'machakann/vim-swap' "swap item g> g< gs
"   theme
Plug 'Lokaltog/vim-monotone' " monotone
Plug 'mhinz/vim-signify' "show changes
Plug 'Yggdroot/indentLine' "display indention levels
Plug 'RRethy/vim-hexokinase' "display color label
Plug 'RRethy/vim-illuminate' "illuminating select
Plug 'itchyny/lightline.vim' "status line
Plug 'andymass/vim-matchup' "match highlight

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
endif
call plug#end()

" -------------
" THEME & COLOR
" -------------
set termguicolors
set t_Co=256
set laststatus=2
set hlsearch
set cursorline
set noshowmode
set lcs+=space:·
let g:monotone_color=[100,1,84]
let g:monotone_secondary_hue_offset=25
let g:monotone_contrast_factor=0.98
colorscheme monotone
syntax on
filetype plugin indent on
filetype plugin on

" cursor shape
set guicursor=i-c-ci-cr-sm:ver20,n-r-v-ve:hor20
autocmd VimLeave,VimSuspend * set guicursor=a:ver20

" disable matchup off-screen match in status line
let g:matchup_matchparen_offscreen = {}

" mark highlight color
hi SignatureMarkText guifg=Green guibg=#1a1b1a
hi SignColumn guibg=#1a1b1a

" vim-illuminate
hi illuminatedWord ctermbg=238 guibg=#3a3a3a

" disable MatchParen syntax in insert mode
augroup matchparentoggle
    autocmd!
    au InsertEnter * NoMatchParen
    au InsertLeave * DoMatchParen
augroup END

" show space character in insert mode
augroup showspacechartoggle
    autocmd!
    au InsertEnter * set list!
    au InsertLeave * set nolist!
augroup END

" file coding utf-8
set encoding=utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030
set nofixendofline

" format
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set fileformats=unix
set mouse+=a
augroup tabstop2
    autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2
    autocmd FileType json setlocal shiftwidth=2 softtabstop=2
    autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2
    autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2
augroup END

" folding
set foldlevel=2
set nofoldenable
let g:markdown_folding=1

" line number
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufEnter,FocusGained,InsertLeave term://* set norelativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" -----------
" KEY MAPPING
" -----------
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
cnoremap <C-v> <C-r>+
vnoremap <C-c> "+y
vnoremap <C-x> "+d
"   easymotion
nmap s <Plug>(easymotion-overwin-f)
map  <Leader>  <Plug>(easymotion-prefix)
"   undotree
nnoremap <F5> :UndotreeToggle<CR>
"   notational-fzf-vim
nnoremap <silent> <c-f> :NV<CR>
"   ale lineter
nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)
"   fzf
nmap <Leader>f :Files<CR>
nmap <Leader>F :GFiles<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>H :Helptags!<CR>
nmap <Leader>l :Lines<CR>
nmap <Leader>c :Commands<CR>
nmap <Leader>M :Maps<CR>
"   coc tab keybinding
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" open file in browser
nnoremap gO :exe ':silent !$BROWSER %'<CR>
" Visual Block mode: Vb or <C-V>
command! Vb execute "normal! \<C-V>"

" --------
" SETTINGS
" --------
set nomodeline
set ignorecase
set smartcase
set lazyredraw

" spell check
augroup vimrc
    autocmd!
    autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us
    autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_us
    autocmd BufNewFile,BufRead *.markdown setlocal spell spelllang=en_us
    autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us
augroup END
set spellfile=~/.vim/spell/en.utf-8.add

" grammar check
let g:grammarous#languagetool_cmd = 'languagetool'

" maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

" nerdcommenter
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not

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
let b:ale_linters = {
    \   'bash': ['shellcheck'],
    \   'css': ['stylelint'],
    \   'javascript': ['eslint'],
    \   'python': ['ruff'],
    \   'vim': ['vint']
    \}
let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'css': ['prettier'],
    \   'javascript': ['eslint'],
    \   'python': ['autopep8'],
    \   'yaml': ['prettier'],
    \   'markdown': ['prettier'],
    \   'json': ['prettier']
    \}
let g:ale_python_ruff_options = '--ignore=E501'
let g:ale_python_autopep8_options = '--max-line-length 256'
let g:ale_fix_on_save = 1
let g:ale_virtualtext_cursor = 'disabled'

" turn off previewwindow
set completeopt-=preview

" syntax folding
setlocal foldmethod=syntax

" notational-fzf-vim
let g:nv_create_note_key = 'ctrl-x'
let g:nv_default_extension = '.md'
let g:nv_search_paths = ['~/Notes', './content/post', './doc', './README.md', './TODO.md']
let g:nv_ignore_pattern = ['.git']
let g:nv_keymap = {
    \ 'ctrl-s': 'split ',
    \ 'ctrl-b': 'vertical split ',
    \ 'ctrl-t': 'tabedit ',
    \ }

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

" enable hexokinase color label
let g:Hexokinase_ftAutoload = ['css', 'xml', 'md']

" indentLine
let g:indentLine_fileTypeExclude = ['markdown']
let g:vim_json_conceal = 0

" easymotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys = 'adehinorst'

" --------
" FUNCTION
" --------
" re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction

" pretty curl
command! PrettyCurl call PrettyCurl()
function! PrettyCurl()
    %s/-X /\\\r  -X /g
    %s/-H /\\\r  -H /g
    %s/-d /\\\r  -d /g
endfunction

" pretty json
command! PrettyJson call PrettyJson()
function! PrettyJson()
    %!python -m json.tool
endfunction
