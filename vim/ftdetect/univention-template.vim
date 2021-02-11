"au BufRead,BufNewFile */base/univention* set ft=ucr-template
"au BufRead,BufNewFile */services/univention* set ft=ucr-template
"au BufRead,BufNewFile */container/univention* set ft=ucr-template
"au BufRead,BufNewFile */virtualization/univention* set ft=ucr-template
"au BufRead,BufNewFile */management/univention* set ft=ucr-template
"au BufRead,BufNewFile */packaging/univention* set ft=ucr-template
"au BufRead,BufNewFile */mail/univention* set ft=ucr-template
"au BufRead,BufNewFile */saml/univention* set ft=ucr-template
"au BufRead,BufNewFile */nagios/univention* set ft=ucr-template
"au BufRead,BufNewFile /etc/univention/* set ft=ucr-template
au BufRead,BufNewFile /conffiles/* set ft=ucr-template
au BufRead,BufNewFile /tmp/* set ft=ucr-template

au BufRead,BufNewFile *.quilt set ft=diff
