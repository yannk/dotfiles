# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export PIP_REQUIRE_VIRTUALENV=true
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin/:~/.vim/bin/:/usr/local/go/bin/:$PATH
export MANPATH=/opt/local/man/:$MANPATH
if [ -x /usr/libexec/java_home ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

## this is specific to macosx + macports
for completion_file in \
    /etc/bash_completion \
    /etc/bash_completion.d/git \
    /opt/local/etc/bash_completion \
    /opt/local/etc/bash_completion.d/git \
    /usr/local/git/contrib/completion/git-completion.bash; do
    if [ -f $completion_file ]; then
        source $completion_file
    fi
done

## check for git dot files in the background
if [ -f ~/.check_git_dotfiles.sh ]; then
    (~/.check_git_dotfiles.sh 2>&1 >/dev/null)&
    disown %- 2>/dev/null
fi

export DISPLAY=:0.0
# allow color with standard macosx tools
export CLICOLOR=1
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

## disable flow-control
stty -ixon

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|xterm-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

function __git_dirty {
    local dirty RED NO_COLOR
#    RED="\033[0;31m"
#    NO_COLOR="\e[0m"
    #dirty=$(git diff-index --cached --quiet HEAD 2>/dev/null || echo "⚡")
    dirty=$(git diff-index --cached --quiet HEAD 2>/dev/null || echo "*")
    if [ ! -z "$dirty" ]; then
        echo "${dirty}"
        return;
    fi
    #dirty=$(git diff-index --quiet HEAD 2>/dev/null || echo "⚡")
    dirty=$(git diff-index --quiet HEAD 2>/dev/null || echo "*")
    [ -z "$dirty" ] && return
    echo "${dirty}"
}

function __git_dotfiles_dirty {
    local markerfile="$HOME/.git_dotfiles.touch"
    [ -e $markerfile ] || return
    content=$(cat $markerfile)
    [ ${content:-""} == 'behind' ] && echo "** "
    return
}

if [[ ("$color_prompt" = yes) && (-n `type -t __git_ps1 2>/dev/null`) ]]; then
    PS1='$(__git_dotfiles_dirty)${debian_chroot:+($debian_chroot)}\[\033[38;5;35m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " [%s$(__git_dirty)]")\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

alias ci=vim
alias gti=git
alias igt=git
alias gt=git
alias gi=git
alias vi=vim
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
alias gpg=gpg2

# Mac OS version of colors, I can't read when sunshine in my place
# this makes it all better
#http://www.geekology.co.za/blog/2009/04/enabling-bash-terminal-directory-file-color-highlighting-mac-os-x/
export LSCOLORS=ExFxCxDxCxegedabagacad
function toomuchsun {
    export LSCOLORS=DxFxCxDxCxegedabagacad
}


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors -o -x /opt/local/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

## re-link SSH_AUTH_SOCK before executing screen/tmux again
_ssh_auth_save() {
    local SSHID=$1
    export MUX_SSH_AUTH_SOCK=$HOME/.ssh/ssh-auth-sock.mux.$SSHID
    ln -sf "$SSH_AUTH_SOCK" $MUX_SSH_AUTH_SOCK
}

_relocate_ssh_auth_sock() {
    local SSHID=$1
    local BASE=$HOME/.ssh
    local SOCK=$BASE/ssh-auth-sock.$SSHID
    if [ -z $SSH_AUTH_SOCK ]; then
        return
    fi
    if [ -n $SOCK ] && [ "$SOCK" != "$SSH_AUTH_SOCK" ]; then
        if [ ! -d $BASE ]; then
            mkdir -p $BASE && chmod 0700 $BASE
        fi
        rm -f $SOCK
        ln -sf "$SSH_AUTH_SOCK" "$SOCK"
        export SSH_AUTH_SOCK=$SOCK
    fi
}
## commented to instead put SSH_AUTH_SOCK in a predictable place
#alias screen='_ssh_auth_save $(hostname); screen'
#alias tmux='_ssh_auth_save $(hostname); tmux'
_relocate_ssh_auth_sock $(hostname)

PERLBREW_RC=$HOME/perl5/perlbrew/etc/bashrc
if [ -f $PERLBREW_RC ]; then
    source $PERLBREW_RC;
fi

## local::lib
eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib 2>/dev/null)

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

