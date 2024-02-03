#!/bin/bash

if [ ! "$(which git)" ]; then
    sudo apt install git
fi

git clone -q https://github.com/dimsanius/dotfiles.git ~/.dotfiles
~/.dotfiles/main.sh -v
