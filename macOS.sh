#!/bin/sh

brew install \
    bat \
    dust \
    exa \
    fish \
    fzf \
    git \
    go \
    hyperkit \
    jq \
    kubectx \
    neovim \
    node \
    ripgrep \
    starship \
    tmux \
    tree \
    zoxide

brew install --cask rectangle
brew install --cask iterm2
brew install --cask docker
brew install --cask wireshark
brew install --cask maccy

brew tap homebrew/cask-fonts
brew install font-Fira-Code-nerd-font \
             font-go-mono-nerd-font \
             font-inconsolata-go-nerd-font \
             font-inconsolata-nerd-font


# for neovim
python3 -m pip install --user --upgrade pynvim
python2 -m pip install --user --upgrade pynvim
npm install -g neovim

echo linking fish, sudo required:
sudo ln -s $(brew --prefix fish)/bin/fish /usr/local/bin/fish

go get github.com/nametake/golangci-lint-langserver
