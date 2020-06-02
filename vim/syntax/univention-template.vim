" Vim syntax file
" Language: conf.python
" Maintainer: Max Christian Pohle <pohle@univention.de>
" Last Change: Jan 20, 2020

if exists("b:current_syntax")
  finish
end

let b:current_syntax = "univention-template"

" embolden normal text to make it a little bit more present than normal python
highlight! Normal cterm=bold gui=bold 

" highlighting for univention config registry
syntax region Define matchgroup=Statement start=/@%@/ end=/@%@/ oneline

unlet b:current_syntax
syntax include @PYTHON syntax/python.vim
syntax region inlinePython
            \ matchgroup=Statement 
            \ start="@!@" end="@!@.*"
            \ contains=@PYTHON 
            \ keepend fold extend
let b:current_syntax = "univention-template"

syntax match Operator '[=;]'

" TODO: further evaluation of:
"       syntax region String  start=/"/ end=/"/
"       syntax keyword Statement include
