#!/bin/sh

sudo apt update
sudo apt install -y python3-venv python3-apt git

wget -qO- https://get.chezmoi.io/lb | sh -s -- init --apply https://github.com/dimsanius/dotfiles.git
