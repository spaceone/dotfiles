unlet b:current_syntax
syntax include @Python syntax/python.vim
syntax region pythonCode  matchgroup=Special start=/@!@/ keepend end=/@!@/ contains=@Python
syntax region ucrVariable matchgroup=Special start=/@%@/ keepend end=/@%@/ contains=ucrWarning
syntax match ucrWarning contained /\<\(BC\|UCR\)WARNING=/
hi def link ucrVariable Special
hi def link ucrWarning PreProc
