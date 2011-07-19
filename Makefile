DOTFILES := $(shell pwd)
GIT := $(shell type -P git)

all: prep git submodules _vim _screen _shell _misc

prep:
	-@mkdir ~/tmp

submodules:
	if [ -x $(GIT) ]; then \
		git submodule sync; \
		git submodule init; \
		git submodule update; \
	fi

git:
	ln -sf $(DOTFILES)/gitconfig 		${HOME}/.gitconfig
	ln -sf $(DOTFILES)/.gitignore 		${HOME}/.gitignore

_vim:
	ln -sf  $(DOTFILES)/vimrc           ${HOME}/.vimrc
	@if [ -d ${HOME}/.vim -a ! -L ${HOME}/.vim ]; then \
	    mv -u ${HOME}/.vim ${HOME}/.vim-backup-`date +%Y%m%d%H%M`; \
	fi
	ln -snf $(DOTFILES)/vim             ${HOME}/.vim

_screen:
	-mkdir ${HOME}/.screen
	-mkdir ${HOME}/.tmux
	ln -sf  $(DOTFILES)/screen_name     ${HOME}/.screen_name
	ln -sf  $(DOTFILES)/screenrc        ${HOME}/.screenrc
	ln -sf  $(DOTFILES)/termcaprc		${HOME}/.termcaprc
	ln -sf  $(DOTFILES)/tmux.conf       ${HOME}/.tmux.conf
	touch ${HOME}/.screenrc-local

_shell:
	ln -sf  $(DOTFILES)/bashrc          ${HOME}/.bashrc
	ln -sf  $(DOTFILES)/bash_profile    ${HOME}/.bash_profile
	ln -sf  $(DOTFILES)/profile         ${HOME}/.profile
	ln -sf  $(DOTFILES)/check_git_dotfiles.sh ${HOME}/.check_git_dotfiles.sh

_misc:
	ln -sf  $(DOTFILES)/ackrc ${HOME}/.ackrc
