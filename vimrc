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
set mouse=a
set mouse=

set laststatus=2
set statusline=%<%F\ %h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P

set showtabline=2

" set nobackup
" set nowb
" set noswapfile

" colorscheme desert
" set background=dark
" call pathogen#infect()
"
" http://www.vim.org/scripts/script.php?script_id=1643
