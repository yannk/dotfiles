#!/bin/sh

set -euo pipefail

DOTFILES=$(pwd)/data

# git
ln -sf ${DOTFILES}/gitconfig ${HOME}/.gitconfig
ln -sf ${DOTFILES}/gitignore ${HOME}/.gitignore
ln -sf ${DOTFILES}/gitattributes ${HOME}/.gitattributes

# vim
ln -sf  ${DOTFILES}/vimrc ${HOME}/.vimrc

# term multiplexers
mkdir -p ${HOME}/.screen ${HOME}/.tmux
ln -sf ${DOTFILES}/screenrc ${HOME}/.screenrc
ln -sf ${DOTFILES}/tmux.conf ${HOME}/.tmux.conf

# shells
ln -sf ${DOTFILES}/bashrc ${HOME}/.bashrc
ln -sf ${DOTFILES}/bash_profile ${HOME}/.bash_profile
ln -sf ${DOTFILES}/profile ${HOME}/.profile
ln -sf ${DOTFILES}/relocate-ssh ${HOME}/.relocate-ssh.bash

mkdir -p ${HOME}/.config/fish
ln -sf ${DOTFILES}/fish/config ${HOME}/.config/fish/config.fish
ln -snfF ${DOTFILES}/fish/functions ${HOME}/.config/fish/functions

mkdir -p ${HOME}/.config/nvim
ln -sf ${DOTFILES}/init.nvim ${HOME}/.config/nvim/init.vim
ln -sf ${DOTFILES}/coc-settings.json ${HOME}/.config/nvim/coc-settings.json
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -sf ${DOTFILES}/starship.toml ${HOME}/.config/starship.toml

if sw_vers >/dev/null 2>&1; then
    # don't interfere with my quick typing in web terminals
    defaults write -g ApplePressAndHoldEnabled -bool false

    ln -sfF ${DOTFILES}/iterm2 ${HOME}/.config/
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${HOME}/.config/iterm2"
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
fi
