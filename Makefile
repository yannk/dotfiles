DOTFILES := $(shell pwd)

all: prep git _screen _shell _misc _vim _go

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

_go:
	cd ~; curl https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar xz; \
	mv go go1.4; \
	git clone https://go.googlesource.com/go; \
	(cd go/src && ./make.bash)
	go get golang.org/x/tools/cmd/goimports golang.org/x/review/git-codereview github.com/tools/godep golang.org/x/tools/cmd/vet github.com/golang/lint/golint golang.org/x/tools/cmd/cover

_misc:
	ln -sf  $(DOTFILES)/ackrc ${HOME}/.ackrc
	#update-alternatives --install /usr/bin/ack ack /usr/bin/ack-grep 100
