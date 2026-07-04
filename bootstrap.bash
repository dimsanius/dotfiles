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

read -p " Git name: " git_name < /dev/tty
read -p " Git email: " git_email < /dev/tty
while true; do
    echo "Select environment:"
    echo " 1. Personal"
    echo " 2. Work"
    echo ""
    read -p " Selection [1-2]: " -n 1 answer < /dev/tty
    echo ""
    echo ""

    if [[ "$answer" == 1 ]]; then
        environment="personal"
        break
    fi

    if [[ "$answer" == 2 ]]; then
        environment="work"
        break
    fi

    echo "Wrong selection. Try again."
done

wget -qO- https://get.chezmoi.io/lb | sh -s -- init "$REPO"

mkdir -p $HOME/.local/share/chezmoi/home/.chezmoidata
cat > $HOME/.local/share/chezmoi/home/.chezmoidata/env.yaml <<EOF
git:
  name: "$git_name"
  email: "$git_email"
environment: "$environment"
EOF
$HOME/.local/bin/chezmoi apply

ln -s \
  "$HOME/.local/share/chezmoi/home/.chezmoidata/env.yaml" \
  "$HOME/.local/share/chezmoi/bootstrap/group_vars/env.yaml"

source "$HOME/.local/share/chezmoi/bootstrap/00_install_ansible.bash"
source "$HOME/.local/share/chezmoi/bootstrap/01_run_ansible.bash"
deactivate || true

source "$HOME/.local/share/chezmoi/bootstrap/99_notice.bash"
