DOTFILES := $(shell pwd)

all: prep git submodules _screen _shell _misc _vim

prep:
	-@mkdir ~/tmp

git:
	ln -sf $(DOTFILES)/gitconfig 		${HOME}/.gitconfig
	ln -sf $(DOTFILES)/.gitignore 		${HOME}/.gitignore

_vim:
	-mkdir -p ${HOME}/.vim/autoload
	curl -fLo ${HOME}/.vim/autoload/plug.vim \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -sf  $(DOTFILES)/vimrc           ${HOME}/.vimrc

_screen:
	-mkdir ${HOME}/.screen
	-mkdir ${HOME}/.tmux
	ln -sf  $(DOTFILES)/screenrc        ${HOME}/.screenrc
	ln -sf  $(DOTFILES)/termcaprc		${HOME}/.termcaprc
	ln -sf  $(DOTFILES)/tmux.conf       ${HOME}/.tmux.conf

_shell:
	ln -sf  $(DOTFILES)/bashrc          ${HOME}/.bashrc
	ln -sf  $(DOTFILES)/bash_profile    ${HOME}/.bash_profile
	ln -sf  $(DOTFILES)/profile         ${HOME}/.profile

_misc:
	ln -sf  $(DOTFILES)/ackrc ${HOME}/.ackrc
	#update-alternatives --install /usr/bin/ack ack /usr/bin/ack-grep 100
