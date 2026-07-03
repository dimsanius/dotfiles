#!/bin/sh

set -e

if [ "${BOOTSTRAP_HTTPS:-0}" = "1" ]; then
    REPO="https://github.com/dimsanius/dotfiles.git"
else
    REPO="git@github.com:dimsanius/dotfiles.git"
fi

sudo apt update
sudo apt install -y \
            python3-venv \
            python3-apt \
            git

wget -qO- https://astral.sh/uv/install.sh | sh
# Adds ~/.local/bin to PATH to allow uv to be discoverable
. $HOME/.local/bin/env

wget -qO- https://get.chezmoi.io/lb | sh -s -- init --apply "$REPO"
