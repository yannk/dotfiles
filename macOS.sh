#!/bin/sh

brew install \
    bat \
    dust \
    exa \
    fish \
    fzf \
    go \
    hyperkit \
    jq \
    neovim \
    node \
    ripgrep \
    starship \
    tmux \
    zoxide

brew install --cask rectangle
brew install --cask iterm2
brew install --cask docker
brew install --cask wireshark

brew tap homebrew/cask-fonts
brew install font-Fira-Code-nerd-font \
             font-go-mono-nerd-font \
             font-inconsolata-go-nerd-font \
             font-inconsolata-nerd-font


# for neovim
python3 -m pip install --user --upgrade pynvim
python2 -m pip install --user --upgrade pynvim
npm install -g neovim
