#! /bin/bash
# interactive login shell

source /etc/profile

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

## this is specific to macosx + macports
for completion_file in \
    /etc/bash_completion \
    /etc/bash_completion.d/git \
    /opt/local/etc/bash_completion \
    /opt/local/etc/bash_completion.d/git \
    /usr/local/opt/git/etc/bash_completion.d/git-prompt.sh \
    /usr/local/opt/git/etc/bash_completion.d/git-completion.bash \
    /usr/local/git/contrib/completion/git-completion.bash; do
    if [ -f $completion_file ]; then
        source $completion_file
    fi
done

# allow color with standard macosx tools
export CLICOLOR=1

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000

# append to the history file, don't overwrite it
shopt -s histappend

# Save and reload the history after each command finishes
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

## disable flow-control
stty -ixon

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUPSTREAM=git
GIT_PS1_SHOWCOLORHINTS=true
# old settings
#PS1='\[\033[38;5;35m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " [%s$(__git_dirty)]")\$ '
# default from doc: PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
PROMPT_COMMAND='__git_ps1 "\u@\033[1;35m\h\033[00m:\w" "\\\$ "'
PS1='\u@\h:\w\$ '

unset color_prompt force_color_prompt

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

# Mac OS version of colors, I can't read when sun shines in my place
# this makes it all better
#http://www.geekology.co.za/blog/2009/04/enabling-bash-terminal-directory-file-color-highlighting-mac-os-x/
#export LSCOLORS=ExFxCxDxCxegedabagacad
#function toomuchsun {
#    export LSCOLORS=DxFxCxDxCxegedabagacad
#}

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

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH=$HOME/bin:$PATH
fi

for extra_path in \
    /usr/local/opt/go/libexec/bin \
    ${HOME}/dev/google-cloud-sdk/arg_rc \ # extra completion for gcloud \
    $HOME/dev/google-cloud-sdk/bin; do
    if [ -f $extra_path ]; then
        export PATH=$PATH:$extra_path
    fi
done

source ~/dotfiles/bin/z.sh
