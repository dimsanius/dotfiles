#!/bin/bash

set -euo pipefail

if [ "${BOOTSTRAP_HTTPS:-0}" = "1" ]; then
    # When BOOTSTRAP_HTTPS is set to 1
    REPO="https://github.com/dimsanius/dotfiles.git"
else
    # When BOOTSTRAP_HTTPS is not set or set to anything but 1
    REPO="git@github.com:dimsanius/dotfiles.git"
fi

sudo apt update
sudo apt install -y \
            python3-venv \
            python3-apt \
            git

if ! command -v uv >/dev/null 2>&1; then 
    wget -qO- https://astral.sh/uv/install.sh | sh
    # Adds ~/.local/bin to PATH to allow uv to be discoverable
    source "$HOME/.local/bin/env"
fi

wget -qO- https://get.chezmoi.io/lb | sh -s -- init --apply "$REPO"

source "$HOME/.local/share/chezmoi/bootstrap/00_install_ansible.bash"
source "$HOME/.local/share/chezmoi/bootstrap/01_run_ansible.bash"
deactivate || true

source "$HOME/.local/share/chezmoi/bootstrap/99_notice.bash"
