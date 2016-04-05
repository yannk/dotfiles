function relocate_ssh_auth_sock
    set -l SSHID $argv[1]
    set -l BASE $HOME/.ssh
    set -l SOCK $BASE/ssh-auth-sock.$SSHID
    if [ -z $SSH_AUTH_SOCK ]
        return
    end
    if [ -n $SOCK ]; and [ "$SOCK" != "$SSH_AUTH_SOCK" ]
        if [ ! -d "$BASE" ]
            mkdir -p $BASE; and chmod 0700 $BASE
        end
        rm -f $SOCK
        ln -sf "$SSH_AUTH_SOCK" "$SOCK"
        set -x SSH_AUTH_SOCK $SOCK
    end
end
