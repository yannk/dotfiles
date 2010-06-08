#!/bin/bash

gitlink="$HOME/.profile"
markerfile="$HOME/.git_dotfiles.touch"
grace=30;

function checkgit {
    local gitfile=$(readlink $gitlink)
    local repo=$(dirname $gitfile)

    if [ -z $repo ]; then
        echo "cannot determine repo home"
        exit;
    fi;

    pushd $repo >/dev/null
    ## <crap> * master 00ab877 [behind 25] commit message
    git fetch
    ## stating at 3.2, the regexp shouldn't be quoted
    if [[ $(git branch -v) =~ "\[behind" ]]; then
        echo "behind" > $markerfile
    else
        echo "ok" > $markerfile
    fi
    popd >/dev/null
}

if [ -e $markerfile ]; then
    ## differences between bsd and linux
    eval $(stat -s $markerfile 2>/dev/null)
    if [ -z $st_mtime ]; then
        st_mtime=$(stat -c "%Y" $markerfile)
        if [ -z $st_mtime ]; then
            echo "something is really wrong"
            exit -1;
        fi
    fi
    now=`date +%s`
    if [ $(( $now - $st_mtime > $grace)) ]; then
        echo "checkgit"
        checkgit
    else
        echo grace
        exit
    fi
else
    checkgit
fi
