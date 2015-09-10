[ -d ~/.bin_overwrite ] && export PATH="~/.bin_overwrite:$PATH";

export EDITOR='vim'
export LANG='de_DE.UTF-8'
export PAGER='less'
[ -e ~/.pythonrc.py ] && export PYTHONSTARTUP=$HOME/.pythonrc.py
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
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

setopt appendhistory autocd extendedglob nomatch notify

setopt histappend nocaseglob #cdspell checkwinsize cmdhist hostcomplete

unsetopt beep
bindkey -e
zstyle :compinstall filename '/home/arch/.zshrc'

autoload -Uz compinit
autoload -Uz vcs_info
compinit

plugins=(git git-flow archlinux autopep8 catimg common-aliases encode64 dirhistory git-extras history jsontools lwd pep8 pyliny pythoan urltools)

seed=$(hostname -f | md5sum | tr -dc '1234567')
hc1=${seed:1:1}
hc2=${seed:2:1}

zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

precmd () { vcs_info }
PS1="%B%F{${hc1}}%n%f%b@%B%F{${hc2}}%M%f%b: %B%F{blue}%~%f%b"$'\n'"%F{yellow}%D{%H:%M:%S}%f%F{green}(%? J%j !%! #%i)%f ${vcs_info_msg_0_}%(!.#.$) "

if [ -x /usr/bin/dircolors ]; then
	[ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

[ -r /usr/share/git/git-prompt.sh ] && . /usr/share/git/git-prompt.sh
[ -r /etc/bash_aliases ] && . /etc/bash_aliases
[ -r ~/.bash_aliases ] && . ~/.bash_aliases
[ -r ~/.univentionrc ] && . ~/.univentionrc
[ -r ~/.homerc ] && . ~/.homerc


#### debian

READNULLCMD=${PAGER:-/usr/bin/pager}

# An array to note missing features to ease diagnosis in case of problems.
typeset -ga debian_missing_features

if [[ -z "$DEBIAN_PREVENT_KEYBOARD_CHANGES" ]] &&
   [[ "$TERM" != 'emacs' ]]
then

    typeset -A key
    key=(
        BackSpace  "${terminfo[kbs]}"
        Home       "${terminfo[khome]}"
        End        "${terminfo[kend]}"
        Insert     "${terminfo[kich1]}"
        Delete     "${terminfo[kdch1]}"
        Up         "${terminfo[kcuu1]}"
        Down       "${terminfo[kcud1]}"
        Left       "${terminfo[kcub1]}"
        Right      "${terminfo[kcuf1]}"
        PageUp     "${terminfo[kpp]}"
        PageDown   "${terminfo[knp]}"
    )

    function bind2maps () {
        local i sequence widget
        local -a maps

        while [[ "$1" != "--" ]]; do
            maps+=( "$1" )
            shift
        done
        shift

        sequence="${key[$1]}"
        widget="$2"

        [[ -z "$sequence" ]] && return 1

        for i in "${maps[@]}"; do
            bindkey -M "$i" "$sequence" "$widget"
        done
    }

    bind2maps emacs             -- BackSpace   backward-delete-char
    bind2maps       viins       -- BackSpace   vi-backward-delete-char
    bind2maps             vicmd -- BackSpace   vi-backward-char
    bind2maps emacs             -- Home        beginning-of-line
    bind2maps       viins vicmd -- Home        vi-beginning-of-line
    bind2maps emacs             -- End         end-of-line
    bind2maps       viins vicmd -- End         vi-end-of-line
    bind2maps emacs viins       -- Insert      overwrite-mode
    bind2maps             vicmd -- Insert      vi-insert
    bind2maps emacs             -- Delete      delete-char
    bind2maps       viins vicmd -- Delete      vi-delete-char
    bind2maps emacs viins vicmd -- Up          up-line-or-history
    bind2maps emacs viins vicmd -- Down        down-line-or-history
    bind2maps emacs             -- Left        backward-char
    bind2maps       viins vicmd -- Left        vi-backward-char
    bind2maps emacs             -- Right       forward-char
    bind2maps       viins vicmd -- Right       vi-forward-char

    # Make sure the terminal is in application mode, when zle is
    # active. Only then are the values from $terminfo valid.
    if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
        function zle-line-init () {
            emulate -L zsh
            printf '%s' ${terminfo[smkx]}
        }
        function zle-line-finish () {
            emulate -L zsh
            printf '%s' ${terminfo[rmkx]}
        }
        zle -N zle-line-init
        zle -N zle-line-finish
    else
        for i in {s,r}mkx; do
            (( ${+terminfo[$i]} )) || debian_missing_features+=($i)
        done
        unset i
    fi

    unfunction bind2maps

fi # [[ -z "$DEBIAN_PREVENT_KEYBOARD_CHANGES" ]] && [[ "$TERM" != 'emacs' ]]

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                           /usr/local/bin  \
                                           /usr/sbin       \
                                           /usr/bin        \
                                           /sbin           \
                                           /bin            \
                                           /usr/X11R6/bin

(( ${+aliases[run-help]} )) && unalias run-help
autoload -Uz run-help
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward; [[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" history-beginning-search-forward
