" Vim file plugin for folding ed/context/unified diffs
" Last Change:  2011 Sep 10
" Maintainer:   Philipp Hahn <pmhahn@debian.org>
" License:      This file is placed in the public domain.

" /usr/share/vim/vim63/syntax/diff.vim

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" ED FORMAT
"
" [E1]  diff old new
" [E2]  0[acd]0,0
" [E3]  < old
" [E4]  > new
" [E5]  ! changed
" [E6]  ---

" CONTEXT FORMAT
"
" [C1]  diff
" OR NOTHING
" [C2]  *** old
" [C3]  --- new
" [C4]  ***************
" [C5]  *** 0,0 ****
" [C6]    unchanged
" [C7]  - removed
" [C8]  + added
" [C9]  ! changed
" [C0]  --- 0,0 ----
" [C6]   unchanged
" [C7]  - removed
" [C8]  + added
" [C9]  ! changed

" UNIFIED DIFF FORMAT
"
" [U1]  Index: foo
" [U2]  ==========
" [OR
" [U3]  diff old new
" OR NOTHING
" [U4]  --- old
" [U5]  +++ new
" [U0]  index 1234567..1234567 100644
" [U6]  @@ -0,0 +0,0 @@
" [U7]  +added
" [U8]  -removed
" [U9]   unchanged

if !exists("*DiffFoldLevel")
  function DiffFoldLevel(l)
    let line = getline(a:l)
    if line =~ '^Index:\s\+' " [U1]
      return '>1'
    elseif line =~ '^====' " [U2]
      if getline(a:l-1) =~ '^Index:\s' && getline(a:l+1) =~ '^---\s'
        return '='
      endif
    elseif line =~ '^diff\s' " [E1,C1,U3]
      if getline(a:l-1) =~ '^====' " [U2]
        return '='
      else
        return '>1'
      endif
    elseif line =~ '^index \x\+\.\.\x\+ \o\+$' " [U0]
      return '='
    elseif line =~ '^\*\{14,\}$' " [C4]
      return '>2'
    elseif line =~ '^\*\*\*\s\d\+,\d\+\s\*\*\*\*\|^---\s\d\+,\d\+\s----' " [C5,C0]
      return '>3'
    elseif line =~ '^\*\*\*\s' " [C2]
      if getline(a:l-1) =~ '^diff\s'
        return '='
      elseif getline(a:l+1) =~ '^---\s'
        return '>1'
      endif
    elseif line =~ '^---\s' " [U4]
      if getline(a:l-1) =~ '^Index: \|^index \x\+\.\.\x\+ \o\+$\|^====\|^diff\s\|^\*\*\*\s'
        return '='
      else
        return '>1'
      endif
    elseif line =~ '^+++\s\+' " [U5]
      return '='
    elseif line =~ '^@@\s\+[0-9,-]\+\s\+[0-9,+]\+\s\+@@\|^\d\+\(,\d\+\)\=[cda]\d\+\>' " [U6,E2]
      return '>2'
    elseif line =~ '^[ +-]\|^[<>!] \|[ !+-] ' " [U7,U8,U9,E3,E4,E5,C6,C7,C8,C9]
      return '='
    elseif line =~ '^\\ No newline at end of file$' " [U]
      return '='
    endif
    return 0
  endfunction
endif

setlocal foldmethod=expr
setlocal foldexpr=DiffFoldLevel(v:lnum)
