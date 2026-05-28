" Vim syntax file
" Language    debian/*.univention-config-registry
" Maintainer  Philipp Hahn <hahn@univention.de>
" Last Change 2012-08-01

" remove old syntax
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

" be case sensitive
syn case match

syn match   ucsucrElse       "^.*$"
syn match   ucsucrKeyword    contained "^\(Type\|File\|Multifile\|Subfile\|Module\|Script\|Variables\|Preinst\|Postinst\|User\|Group\|Mode\): *"
syn match   ucsucrDeprecated contained "^Encode-utf8: *"
syn keyword ucsucrType       contained file multifile subfile module script
syn match   ucsucrMode       contained "[0-7]\+$"
syn region  ucsucrStrictField  start="^Type: *\S.*" end="$" contains=ucsucrKeyword,ucsucrType oneline
syn region  ucsucrStrictField  start="^Mode: *\S.*" end="$" contains=ucsucrKeyword,ucsucrMode oneline
syn region  ucsucrField      start="^\(File\|Multifile\|Subfile\|Module\|Script\|Variables\|Preinst\|Postinst\|User\|Group\|Encode-utf8\): *\S.*" end="$" contains=ucsucrKeyword,ucsucrDeprecated oneline

hi def link ucsucrElse Error
hi def link ucsucrKeyword Identifier
hi def link ucsucrDeprecated Todo
hi def link ucsucrType Constant
hi def link ucsucrMode Number
hi def link ucsucrStrictField Error
hi def link ucsucrField String

let b:current_syntax="ucsucr"
