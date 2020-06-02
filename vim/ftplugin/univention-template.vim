" this filetype plugin should be placed under ~/.vim/pack/univention/start/plugin/ftplugin/ or ~/.vim/ftplugin if you
" need it simpler. Keep in mind, that this file requires a syntax file with the same name to work properly and it is
" more convinient to use if you additionally add the ftdetect-file.

syntax on

setlocal nofoldenable
setlocal foldtext=getline(v:foldstart).printf('\ [%d\ lines]\ \ \ \',\ v:foldend-v:foldstart)
setlocal foldmethod=syntax
" manually :set foldlevel=0 in order to fold all @!@-blocks if you want visual clearity
setlocal foldlevel=1

match Error /print()/

" prepend the @!@ block under the cursor with the usual python header for templates and return the result as a list
function! Univention_test_template_section()
    return ["# -*- coding: utf-8 -*-",
          \ "import univention.config_registry",
          \ "configRegistry = univention.config_registry.ConfigRegistry()",
          \ "configRegistry.load()",
          \ "# for compatibility",
          \ "baseConfig = configRegistry",
          \ "",
          \ ] + getline(search('@!@', 'nb') + 1, search('@!@', 'n') - 1)
endfunction

" display the contents of the @!@-section in the preview window
nnoremap <F3> :call writefile(Univention_test_template_section(), "/tmp/foobar.txt")\|:vertical pedit +setlocal\ number /tmp/foobar.txt<CR>
" display the contents of the @!@ in the console with line numbers (nl), " without a temporary file
nnoremap <F4> :echo system("nl", Univention_test_template_section())<CR>
" execute the @!@ section in python2 (wysiwyg: it is unnecessary to write the file)
nnoremap <F5> :echo system("python2", Univention_test_template_section())<CR>
" execute the @!@ section in python3 (wysiwyg: it is unnecessary to write the file)
nnoremap <F6> :echo system("python3", Univention_test_template_section())<CR>
" shows the differences between the current branch and ucs master using vimdiff
nnoremap <F7> :Gdiffsplit 4.4-3<CR>
" If syntastic plugin is installed, we can use its pep8 checker capability, covers more than @!@ sections unfortunatelly
nnoremap <F8> :SyntasticCheck python/pep8<CR>

" TODO: syntastic does not recognize the new filetype -possibly due to the
" minus in the file name. NOT working yet, use <F8> instead:
let b:syntastic_checkers = [ 'pep8' ]
let g:syntastic_extra_filetypes = [ "univention-template" ]
let g:syntastic_univention_template_checkers=[ 'pep8' ]
