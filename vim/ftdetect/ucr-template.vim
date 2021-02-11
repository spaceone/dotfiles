" This file is part of the ucr-template plugin
function DetectUCRtemplate()
    for i in [1, 2] + range(3, &modelines)
        if getline(i) =~ '^@%@\(BC\|UCR\)WARNING\(_ASCII\)\?' ||
         \ getline(i) =~ '^@!@'
            set filetype=ucr-template.python
        endif
    endfor
endfunction
au BufRead * call DetectUCRtemplate()
