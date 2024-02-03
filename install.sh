#!/bin/bash

if [ ! "$(which git)" ]; then
    echo "==> Git not found. Installing git..."
    sudo apt install git
fi

git clone -q git@github.com:dimsanius/dotfiles.git ~/.dotfiles
~/.dotfiles/main.sh -v
