#!/bin/bash

if [ ! "$(which git)" ]; then
    echo "git is not installed. Please install git using your distro's package manager. Exitting."
    exit 1
fi

mkdir -p ~/.misc
git clone -q https://github.com/dimsanius/dotfiles.git ~/.misc/dotfiles
~/.misc/dotfiles/main.sh -ipv
