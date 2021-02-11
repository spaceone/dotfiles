" this filetype plugin should be placed under ~/.vim/pack/univention/start/plugin/ftplugin/ or ~/.vim/ftplugin if you
" need it simpler. Keep in mind, that this file requires a syntax file with the same name to work properly and it is
" more convinient to use if you additionally add the ftdetect-file.

syntax on

let &l:textwidth        = get(g:, 'ucr_template_textwidth', 120)

" Handle code folding correctly and make that feature be configurable
if get(g:, 'ucr_template_autofold', 1)
    setlocal foldmethod=syntax
    setlocal foldenable
    setlocal foldlevel=1
else
    setlocal foldlevel=0
endif

" highlight print() statements (empty braces), because that is not compatible
" between python2 and python3 and is not handled by 2to3
match Error /print()/

" prepend the @!@ block under the cursor with the usual python header for templates and return the result as a list
function! Univention_test_template_section() abort
    let [l:brow, l:bcol] = searchpos('@!@', 'nbcW')
    let [l:erow, l:ecol] = searchpos('@!@', 'nW')
    let l:lines = getline(l:brow, l:erow)
    let l:lines[-1] = strpart(l:lines[-1], 0, l:ecol - 1)
    let l:lines[0] = strpart(l:lines[0], l:bcol + 2)

    return ["# -*- coding: utf-8 -*-",
          \ "import univention.config_registry",
          \ "configRegistry = univention.config_registry.ConfigRegistry()",
          \ "configRegistry.load()",
          \ "# for compatibility",
          \ "baseConfig = configRegistry",
          \ "",
          \ ] + l:lines
endfunction

" Preview the code section
" ========================
" displays the contents and usual preamble of a @!@-section
command! UCRSectionPreviewSimple echo system("nl", Univention_test_template_section())
" displays the contents and usual preamble of a @!@-section in the preview window
function! UCRSectionPreview()
    let Tempfile = tempname()
    call writefile(Univention_test_template_section(), Tempfile)
    execute ':pedit +setlocal\ number ' . Tempfile
    echo "saving to " . Tempfile
endfunction
command! UCRSectionPreview call UCRSectionPreview()



" Diff in output between Python2 and Python3
" ==========================================
" execute the @!@ section in python2 or python3 or in a diff mode between both.
" that works wysiwyg in that it is not necessary to write the file
command! UCRSectionToPython2 echo system(get(g:, 'ucr_python2_command', "python2"), Univention_test_template_section())
command! UCRSectionToPython3 echo system(get(g:, 'ucr_python3_command', "python3"), Univention_test_template_section())
function! UCRSectionDiffPython()
    let Py2File = tempname()
    let Py3File = tempname()
    let DifFile = tempname()
    call writefile(systemlist(get(g:, 'ucr_python2_command', "python2"), Univention_test_template_section()), Py2File)
    call writefile(systemlist(get(g:, 'ucr_python3_command', "python3"), Univention_test_template_section()), Py3File)
    call system("diff -u " . Py2File . " " . Py3File . ' > ' . DifFile)
    execute ":new \| :edit " .  Py2File . "\|" . ":vert diffpatch " . DifFile
endfunction
command! UCRSectionDiffPython call UCRSectionDiffPython()

