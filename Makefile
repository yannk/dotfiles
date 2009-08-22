DOTFILES := $(shell pwd)

all: _vim _screen _shell

_vim:
	ln -sf  $(DOTFILES)/vimrc           ${HOME}/.vimrc
	@if [ -d ${HOME}/.vim -a ! -L ${HOME}/.vim ]; then \
	    mv -u ${HOME}/.vim ${HOME}/.vim-backup-`date +%Y%m%d%H%M`; \
	fi
	ln -snf $(DOTFILES)/vim             ${HOME}/.vim

_screen:
	ln -sf  $(DOTFILES)/screen_name     ${HOME}/.screen_name
	ln -sf  $(DOTFILES)/screenrc        ${HOME}/.screenrc
	ln -sf  $(DOTFILES)/termcaprc		${HOME}/.termcaprc
	touch ${HOME}/.screenrc-local

_shell:
	ln -sf  $(DOTFILES)/bashrc          ${HOME}/.bashrc
	ln -sf  $(DOTFILES)/profile         ${HOME}/.profile

