#! /bin/bash

source /etc/profile

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

[[ -s $USER/.nvm/nvm.sh ]] && . $USER/.nvm/nvm.sh # This loads NVM
