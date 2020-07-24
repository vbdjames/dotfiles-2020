set nocompatible
filetype off

call plug#begin()

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Plugin 'kien/ctrlp.vim'
" Plugin 'Shutnik/jshint2.vim'
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'twerth/ir_black'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-jdaddy'
Plug 'elzr/vim-json'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plugin 'Shougo/neocomplete.vim'
" Plugin 'editorconfig/editorconfig-vim'
" Plugin 'aklt/plantuml-syntax'
" Plugin 'hdima/python-syntax'
" Plugin 'fatih/vim-go'
Plug 'fmoralesc/vim-pad', { 'branch': 'devel' }
" Plugin 'fmoralesc/vim-tutor-mode'
" Plugin 'guns/vim-clojure-static'
" Plugin 'kien/rainbow_parentheses.vim'
" Plugin 'tpope/vim-fireplace'
" Plugin 'tpope/vim-classpath'
" Plugin 'lambdatoast/elm.vim'
" Plugin 'darfink/vim-plist'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'itspriddle/vim-marked'

call plug#end()

let mapleader=","
" syntax enable
filetype plugin indent on
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set relativenumber
set number
set guifont=Source\ Code\ Pro:h15

" autocmd Filetype html setlocal ts=2 sts=2 sw=2

silent! colorscheme solarized
silent! set background=dark
silent! call togglebg#map("<F5>")

set wildignore+=.DS_Store
hi MatchParen guibg=NONE guifg=NONE gui=underline ctermbg=NONE ctermfg=NONE cterm=underline
set ignorecase
set smartcase

let g:UltiSnipsExpandTrigger="<c-tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" let g:UltiSnipsEditSplit="vertical"

let g:neocomplete#enable_at_startup = 1

" Syntastic settings
let g:syntastic_javascript_checkers = ['jscs', 'jshint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" let &colorcolumn=join(range(81,999),",")

" Vim-pad settings
let g:pad#dir = '~/Documents/Projects/Notes'
let g:pad#open_in_split = 0
" let g:pad#position = { "list" : "right", "pads" : "bottom" }
let g:pad#title_first_line = 0
let g:pad#read_nchars_from_files = 0
let g:pad#search_backend = 'ag'

" ctrlp configuration
" let g:ctrlp_max_files=0

" NERDTree configuration
" map <silent> <C-n> :NERDTreeToggle<CR> 
" let NERDTreeHijackNetrw=1

set nobackup
set noswapfile

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nmap <leader>ss<left>  :topleft vnew<CR>
nmap <leader>ss<right> :botright vnew<CR>
nmap <leader>ss<up>    :topleft new<CR>
nmap <leader>ss<down>  :botright new<CR>
nmap <leader>s<left>   :leftabove vnew<CR>
nmap <leader>s<right>  :rightbelow vnew<CR>
nmap <leader>s<up>     :leftabove new<CR>
nmap <leader>s<down>   :rightbelow new<CR>

" Yank text to the OS X clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y
" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
elseif &term=~'xterm-256color' " terminal
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

map ,t :w\|:!%:p<cr>

nmap <silent> ,/ :nohlsearch<CR>

