DOTFILES := $(shell pwd)

all: prep git submodules _vim _screen _shell

prep:
	-@mkdir ~/tmp

submodules:
	if [ -x git ]; then \
		git submodule init; \
		git submodule update; \
	fi

git:
	ln -sf $(DOTFILES)/gitconfig 		${HOME}/.gitconfig

_vim:
	ln -sf  $(DOTFILES)/vimrc           ${HOME}/.vimrc
	@if [ -d ${HOME}/.vim -a ! -L ${HOME}/.vim ]; then \
	    mv -u ${HOME}/.vim ${HOME}/.vim-backup-`date +%Y%m%d%H%M`; \
	fi
	ln -snf $(DOTFILES)/vim             ${HOME}/.vim
	cat $(DOTFILES)/vimplaterc | perl -pe 's{\$$HOME}{${HOME}}g' > ${HOME}/.vimplaterc

_screen:
	ln -sf  $(DOTFILES)/screen_name     ${HOME}/.screen_name
	ln -sf  $(DOTFILES)/screenrc        ${HOME}/.screenrc
	ln -sf  $(DOTFILES)/termcaprc		${HOME}/.termcaprc
	touch ${HOME}/.screenrc-local

_shell:
	ln -sf  $(DOTFILES)/bashrc          ${HOME}/.bashrc
	ln -sf  $(DOTFILES)/bash_profile    ${HOME}/.bash_profile
	ln -sf  $(DOTFILES)/profile         ${HOME}/.profile

