#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

if [ ! "$(which git)" ]; then
    echo "==> Git not found. Installing git..."
    sudo apt install git
fi

git clone -q git@github.com:dimsanius/dotfiles.git ~/.dotfiles
~/.dotfiles/main.sh -v
