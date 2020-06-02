" Vim compiler file for Python
" Compiler:     Style checking tool for Python
" Maintainer:   Philipp Hahn <hahn@univention.de>
" Last Change:  2012 Jun 25
" Version:      1
" Contributors:
"
" Installation:
"   Drop pep8.vim in ~/.vim/compiler/ directory. Ensure that your PATH
"   environment variable includes the path to 'pep8' executable.
"
"   Add the following line to the autocmd section of .vimrc
"
"      autocmd FileType python compiler pep8
"
" Usage:
"   Pep8 is called after a buffer with Python code is saved. QuickFix
"   window is opened to show errors, warnings and hints provided by Pep8.
"
"   Above is realized with :Pep8 command. To disable calling Pep8 every
"   time a buffer is saved put into .vimrc file
"
"       let g:pep8_onwrite = 0
"
"   Openning of QuickFix window can be disabled with
"
"       let g:pep8_cwindow = 0
"
"   Of course, standard :make command can be used as in case of every
"   other compiler.
"


if exists('current_compiler')
  finish
endif
let current_compiler = 'pep8'

if !exists('g:pep8_onwrite')
    let g:pep8_onwrite = 1
endif

if !exists('g:pep8_cwindow')
    let g:pep8_cwindow = 1
endif

if exists(':Pep8') != 2
    command Pep8 :call Pep8(0)
endif

if exists(":CompilerSet") != 2          " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" We should echo filename because pep8 truncates .py
" If someone know better way - let me know :)
CompilerSet makeprg=(pep8\ -r\ %)

" We could omit end of file-entry, there is only one file
" %+I... - include code rating information
" %-G... - remove all remaining report lines from quickfix buffer
CompilerSet errorformat=\%f:%l:%c:\ %t%n\ %m,%Z

if g:pep8_onwrite
    augroup python
        au!
        au BufWritePost * call Pep8(1)
    augroup end
endif

function! Pep8(writing)
    if !a:writing && &modified
        " Save before running
        write
    endif

    if has('win32') || has('win16') || has('win95') || has('win64')
        setlocal sp=>%s
    else
        setlocal sp=>%s\ 2>&1
    endif

    " If check is executed by buffer write - do not jump to first error
    if !a:writing
        silent make
    else
        silent make!
    endif

    if g:pep8_cwindow
        cwindow
    endif
endfunction
