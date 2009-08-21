DOTFILES := $(shell pwd)

all: _vim _screen

_vim:
	ln -sf  $(DOTFILES)/vimrc ${HOME}/.vimrc
	ln -snf $(DOTFILES)/vim   ${HOME}/.vim

_screen:
	ln -sf  $(DOTFILES)/screen_name ${HOME}/.screen_name
	ln -sf  $(DOTFILES)/screenrc    ${HOME}/.screenrc
	touch ${HOME}/.screenrc-local
