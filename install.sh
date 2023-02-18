#!/usr/bin/env bash

if [ ! "$(code --version)" ]; then
    echo "VSCode not installed, exiting..."
    exit 1
fi

mkdir -p ~/.misc
git clone -q https://github.com/dimsanius/dotfiles ~/.misc/dotfiles/vscode-extensions
~/.misc/dotfiles/vscode-extensions/main.sh
