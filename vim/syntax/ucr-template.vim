" Vim syntax file
" Language: conf.python
" Maintainer: Max Christian Pohle <pohle@univention.de>
" Last Change: Jan 20, 2020

if exists("b:current_syntax")
  finish
end

let b:current_syntax = "ucr-template"

" embolden normal text to make it a little bit more present than normal python
highlight! Normal cterm=bold gui=bold

" highlighting for univention config registry
syntax region ucrVariableRegion matchgroup=Statement start=/@%@/ end=/@%@/ oneline contains=ucrWarning,bcWarning
syntax match ucsVariable contained ".*" contains=ucrWarning
syntax match ucrWarning contained /\<UCRWARNING\(_ASCII\)\?=/
syntax match bcWarning contained /\<BCWARNING=/

unlet b:current_syntax
syntax include @PYTHON syntax/python.vim
syntax region inlinePython
            \ matchgroup=Statement
            \ start="@!@" end="@!@.*"
            \ contains=@PYTHON
            \ keepend fold extend
let b:current_syntax = "ucr-template"

syntax match Operator '[=;]'
hi def link ucrVariableRegion Special
hi def link ucrVariable Identifier
hi def link ucrWarning PreProc
hi def link bcWarning Error

" TODO: further evaluation of:
"       syntax region String  start=/"/ end=/"/
"       syntax keyword Statement include
