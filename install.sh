#!/bin/sh

# Dummy sudo command to (maybe) allow executing sudo later
sudo test 1

if [ ! "$(which git)" ]; then
    echo "==> Git not found. Installing git..."
    sudo apt install git -y
fi

echo "==> Acquiring GitHub keys..."
# Not quite reliable, but this should get GitHub SSH keys for interaction-less repo clone
ssh-keyscan -H github.com >>~/.ssh/known_hosts 2>/dev/null

git clone git@github.com:dimsanius/dotfiles.git ~/.dotfiles

if [ $? -ne 0 ]; then
    echo "Git clone failed. Please check your SSH keys."
    exit 1
fi

~/.dotfiles/main.sh -v
