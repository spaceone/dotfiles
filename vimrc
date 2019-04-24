filetype plugin on
filetype indent on
syntax on
colorscheme delek

au BufNewFile,BufRead *.styl set filetype=css

set incsearch
set hlsearch

set nocompatible

set encoding=utf8

set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4

set autoindent
set si "Smart indent
set wrap "Wrap lines

" Be smart when using tabs ;)
set smarttab

" When searching try to be smart about cases
set smartcase

set wildmode=longest,list,full
set wildmenu

set number
set pastetoggle=<F2>

if $LANG =~ ".*\.UTF-8$" || $LANG =~ ".*utf8$" || $LANG =~ ".*utf-8$"
	try
		set listchars=tab:»\ ,trail:·,precedes:…,extends:…
		set list
	catch
	endtry
endif

set foldmethod=indent
set foldlevel=99
set mouse=

set laststatus=2
set statusline=%<%F\ %h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P

set showtabline=2

" set nobackup
" set nowb
" set noswapfile

" colorscheme desert
" set background=dark

" disable enforced PEP8
let g:python_recommended_style=0

" syntax checks using syntastics
execute pathogen#infect()

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

nnoremap <silent> <F7> :SyntasticToggleMode<CR>
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:autopep8_ignore="E501,W191,E265"
let g:pymode_lint_ignore="E501,W191,E265"

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_python_checkers = ['flake8', 'pyflakes', 'pep8']

" supertab!
" http://www.vim.org/scripts/script.php?script_id=1643
