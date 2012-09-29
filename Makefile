DOTFILES := $(shell pwd)
GIT := $(shell type -P git)

all: prep git submodules _screen _shell _misc spf13-vim _vim

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
	ln -sf  $(DOTFILES)/vimrc.local           ${HOME}/.vimrc.local
	ln -sf  $(DOTFILES)/vimrc.bundles.local  ${HOME}/.vimrc.bundles.local

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
	#update-alternatives --install /usr/bin/ack ack /usr/bin/ack-grep 100

spf13-vim:
	git clone --recursive http://github.com/spf13/spf13-vim.git
	cd spf13-vim && bash bootstrap.sh

update-spf13: spf13-vim
	cd spf13-vim && git pull --rebase && vim +BundleInstall! +BundleClean +q
