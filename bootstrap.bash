#!/bin/bash

set -euo pipefail

# Set SSH repo as a default
REPO="git@github.com:dimsanius/dotfiles.git"

if [[ "${BOOTSTRAP_HTTPS:-0}" == "1" ]]; then
    # Update target if flag is set
    REPO="https://github.com/dimsanius/dotfiles.git"
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

echo ""
echo ""
echo "Input user data below:"
read -p " Git name: " git_name < /dev/tty
read -p " Git email: " git_email < /dev/tty
while true; do
    echo "  Select target environment:"
    echo "    1. Personal"
    echo "    2. Work"
    echo ""
    read -p "  Selection [1-2]: " -n 1 answer < /dev/tty
    echo ""
    echo ""

    if [[ "$answer" == 1 ]]; then
        target_env="personal"
        break
    fi

    if [[ "$answer" == 2 ]]; then
        target_env="work"
        break
    fi

    echo "Wrong selection. Try again."
done

wget -qO- https://get.chezmoi.io/lb | sh -s -- init "$REPO"


CHEZMOI_DIR="$HOME/.local/share/chezmoi"
CHEZMOIDATA_DIR="$CHEZMOI_DIR/home/.chezmoidata"
BOOTSTRAP_DIR="$CHEZMOI_DIR/bootstrap"
CHEZMOI_BIN="$HOME/.local/bin/chezmoi"

mkdir -p "$CHEZMOIDATA_DIR"
cat > "$CHEZMOIDATA_DIR/all.yaml" <<EOF
git:
  name: "$git_name"
  email: "$git_email"
target_env: "$target_env"
EOF
"$CHEZMOI_BIN" apply

ln -s \
  "$CHEZMOIDATA_DIR/all.yaml" \
  "$BOOTSTRAP_DIR/group_vars/all.yaml"

source "$BOOTSTRAP_DIR/00_install_ansible.bash"
source "$BOOTSTRAP_DIR/01_run_ansible.bash"
deactivate || true

source "$BOOTSTRAP_DIR/99_notice.bash"
