#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root or sudo"
    exit 1
fi

if [ ! "$(which git)" ]; then
    echo "==> Git not found. Installing git..."
    sudo apt install git -y
fi

git clone -q git@github.com:dimsanius/dotfiles.git ~/.dotfiles
~/.dotfiles/main.sh -v
