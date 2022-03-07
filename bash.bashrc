# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="~/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin:/usr/local/sbin:/sbin"

[ -d ~/.bin_overwrite ] && export PATH="~/.bin_overwrite:$PATH"

export EDITOR='vim'
export LANG='de_DE.UTF-8'
export PAGER='less'
[ -e ~/.pythonrc.py ] && export PYTHONSTARTUP=$HOME/.pythonrc.py
export GREP_COLOR='1;32'
PROMPT_COMMAND='history -a' # write out history after each command

GLOBIGNORE=".svn"
HISTCONTROL='ignorespace:erasedups'
HISTFILESIZE=32768
HISTIGNORE='clear:exit:fg:bg'
HISTSIZE=32768

# colorful manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS='-iFRXM'

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob

if [ -x /usr/bin/dircolors ]; then
	[ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

[ -r /usr/share/git/git-prompt.sh ] && . /usr/share/git/git-prompt.sh
[ -r /etc/bash_aliases ] && . /etc/bash_aliases
[ -r ~/.bash_aliases ] && . ~/.bash_aliases
[ -r ~/.univentionrc ] && . ~/.univentionrc
[ -r ~/.homerc ] && . ~/.homerc

[ -r /etc/bash_completion ] && . /etc/bash_completion
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


function_exists() {
	declare -f -F $1 > /dev/null
	return $?
}
seed=$(hostname -f | md5sum | tr -dc '1234567')
hc1=${seed:1:1}
hc2=${seed:2:1}
PS1="\${debian_chroot:+\[\e[01;31m\](\$debian_chroot)}\[\e[01;3${hc1}m\]\u\[\e[00m\]@\[\e[01;3${hc2}m\]\h\[\e[00m\]: \[\e[01;34m\]\w\[\e[00m\]\n\[\e[00;33m\]\t\[\e[00;32m\](\$? J\j !\! #\#)\[\e[00m\]"
if function_exists __git_ps1 ;then
	PS1="$PS1\$(__git_ps1 ' \[\e[01;30m\](%s) \[\e[00m\]')\\\$ "
fi
PS2='> '
PS3='> '
PS4='+ '
