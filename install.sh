#!/bin/bash

if [ ! "$(which git)" ]; then
    echo "git is not installed. Please install git using your distro's package manager. Exitting."
    exit 1
fi

git clone -q https://github.com/dimsanius/dotfiles.git ~/.dotfiles
~/.dotfiles/main.sh -ipv
