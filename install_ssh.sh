#!/bin/sh

sudo apt update
sudo apt install -y python3-venv python3-apt curl git

sh -c "$(wget -q0- get.chezmoi.io/lb)" -- init --apply git@github.com:dimsanius/dotfiles.git
