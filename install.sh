#!/bin/sh

DOTFILES=$(pwd)/data

# git
ln -sf ${DOTFILES}/gitconfig ${HOME}/.gitconfig
ln -sf ${DOTFILES}/gitignore ${HOME}/.gitignore

# vim
mkdir -p ~/tmp
mkdir -p ${HOME}/.vim/autoload
curl -fLo ${HOME}/.vim/autoload/plug.vim \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sf  ${DOTFILES}/vimrc ${HOME}/.vimrc

# term multiplexers
mkdir -p ${HOME}/.screen ${HOME}/.tmux
ln -sf ${DOTFILES}/screenrc ${HOME}/.screenrc
ln -sf ${DOTFILES}/tmux.conf ${HOME}/.tmux.conf
# hopefully not needed anymore
#ln -sf  ${DOTFILES}/termcaprc ${HOME}/.termcaprc

# shells
ln -sf ${DOTFILES}/bashrc ${HOME}/.bashrc
ln -sf ${DOTFILES}/bash_profile ${HOME}/.bash_profile
ln -sf ${DOTFILES}/profile ${HOME}/.profile
ln -sf ${DOTFILES}/zshrc ${HOME}/.zshrc

mkdir -p ${HOME}/.config/fish
ln -sf ${DOTFILES}/fish/config ${HOME}/.config/fish/config.fish
ln -sf ${DOTFILES}/fish/functions ${HOME}/.config/fish/functions

. update-z.sh
