#!/bin/bash

gitlink="$HOME/.profile"
markerfile="$HOME/.git_dotfiles.touch"
grace=30;

function checkgit {
    local gitfile=$(readlink $gitlink)
    local repo=$(dirname $gitfile)

    if [[ -z $repo ]]; then
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

if [[ -e $markerfile ]]; then
    eval $(stat -s $markerfile)
    if [[ $(( $now - $st_mtime > $grace)) ]]; then
        checkgit
    else
        echo grace
        exit
    fi
else
    checkgit
fi
