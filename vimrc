filetype plugin on
filetype indent on
syntax on
colorscheme delek

au BufNewFile,BufRead *.styl set filetype=css

set tabpagemax=30

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
let g:indentLine_enabled = 1
let g:indentLine_enabled = 0
let g:indentLine_char = '»'
let g:indentLine_first_char = '»'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_defaultGroup = 'SpecialKey'

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

" https://github.com/vim-syntastic/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

nnoremap <silent> <F8> :set mouse= \| set nolist \| set nonumber<CR>
nnoremap <silent> <F9> :set mouse= \| set list \| set number<CR>

nnoremap <silent> <F7> :SyntasticToggleMode<CR>
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_javascript_checkers = ['jslint', 'eslint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['flake8', 'pycodestyle', 'pyflakes']
"let g:syntastic_python_flake8_args = ['--ignore', 'I,W191']
", 'bandit']
"let g:syntastic_python_checkers = ['ucspep8']  # pydocstyle
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_sh_shellcheck_args = ['--external-sources']
" 'bandit'

" https://github.com/tell-k/vim-autopep8
let g:autopep8_ignore="E501,W191,E265"
let g:pymode_lint_ignore="E501,W191,E265"

" supertab: http://www.vim.org/scripts/script.php?script_id=1643

let g:ucr_template_autofold=2
augroup ucr-template_filetype
  autocmd!
  autocmd FileType ucr-template nnoremap <buffer> <F5> :UCRSectionToPython2<CR>
  autocmd FileType ucr-template nnoremap <buffer> <F6> :UCRSectionToPython3<CR>
  autocmd FileType ucr-template nnoremap <buffer> <F9> :UCRSectionDiffPython<CR>
  autocmd FileType ucr-template nnoremap <buffer> <F8> :UCRSectionPreview<CR>
augroup END

function! Ef()
  write
  execute "!PYTHONPATH=/home/fbest/git2/repo-ng/src python -m univention.repong.errata format --wrap=80 -s -i " . bufname("%")
  edit
endfunction

let g:DiffUnit="Word1"

autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
