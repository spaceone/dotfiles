#!/bin/bash

alias mv='mv -vi'
alias cp='cp -vi'
alias rm='rm -vi'
alias rmq='/bin/rm'
alias rmr='rm -rv'
alias mkdir='mkdir -pv'
alias ..='cd ..'
alias cd.='cd ..'
alias cd..='cd ..'
alias …='cd ../..'
alias ….='cd ../../../'
alias h='history'
alias j='jobs -l'
alias L='less'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias rgrep='grep -r'
alias cl='clear; ls'
alias du='du -kh'
alias df='df --si -kThlx tmpfs'

alias vi='vim'
alias diff='diff -u'
alias dch='dch -i --no-auto-nmu'
alias ping='ping -c1'
alias free='free -m'
alias sudo='su -c root'
alias x="tar -xvf"
alias wget='wget --referer="http://www.google.com" --user-agent="Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/9"'
alias weechat='weechat-curses'

alias ls='ls --si -hA --color=auto --group-directories-first'
alias la='ls -AF'
alias lla='ls -AFl'
alias ll='ls -flAh  --color=auto --group-directories-first'
alias l='ls -CF'
alias lr='ls -lR'
alias lc='ls -ltcr'
alias lu='ls -ltur'
alias tree='tree -Csu'

alias grephist='history | grep'
alias histless='history | less'
alias topu='top -u "$USER"'
alias ack='ack-grep'

#IP=$(/sbin/ifconfig eth0 | awk '/inet / { print $2 }')

function mkcd () {
  mkdir -p "$1"
  cd "$1"
}
