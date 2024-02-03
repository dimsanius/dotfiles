#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root or sudo"
    exit 1
fi

if [ ! "$(which git)" ]; then
    echo "==> Git not found. Installing git..."
    sudo apt install git -y
fi

# Not quite reliable, but this should get GitHub SSH keys for interaction-less repo clone
ssh-keyscan -H github.com >>~/.ssh/known_hosts 2>/dev/null

git clone -q git@github.com:dimsanius/dotfiles.git ~/.dotfiles

if [ $? -ne 0 ]; then
    echo "Git clone failed. Please check your SSH keys."
    exit 1
fi

~/.dotfiles/main.sh -v
