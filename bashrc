# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

PERLBREW_RC=$HOME/perl5/perlbrew/etc/bashrc
if [ -f $PERLBREW_RC ]; then
    source $PERLBREW_RC;
fi

# damn .pyc, go away
export PYTHONDONTWRITEBYTECODE=1

export GPG_TTY=`tty`
export PIP_REQUIRE_VIRTUALENV=true
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim
export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:$PATH
export MANPATH=/opt/local/man/:$MANPATH
export GOPATH=$HOME
#if [ -x /usr/libexec/java_home ]; then
#    export JAVA_HOME=$(/usr/libexec/java_home)
#fi

export DISPLAY=:0.0
