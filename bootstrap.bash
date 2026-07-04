#!/bin/bash

set -euo pipefail

# ----------------------------
# Configuration
# ----------------------------
REPO_SSH="git@github.com:dimsanius/dotfiles.git"
REPO_HTTPS="https://github.com/dimsanius/dotfiles.git"

CHEZMOI_DIR="$HOME/.local/share/chezmoi"
CHEZMOIDATA_DIR="$CHEZMOI_DIR/home/.chezmoidata"
BOOTSTRAP_DIR="$CHEZMOI_DIR/bootstrap"
CHEZMOI_BIN="$HOME/.local/bin/chezmoi"

# Set SSH repo as a default
TARGET_REPO="$REPO_SSH"
# Update target if flag is set
[[ "${BOOTSTRAP_HTTPS:-0}" == "1" ]] && TARGET_REPO="$REPO_HTTPS"

# ----------------------------
# Helpers
# ----------------------------

log() { echo "→ $*" >&2; }
run() { log "$*"; "$@"; }
log_pipe() { echo "→ $*" >&2; }

run_script() {
    source "$BOOTSTRAP_DIR/$1"
}

# ----------------------------
# Stages
# ----------------------------

bootstrap_system() {
    run sudo apt update
    run sudo apt install -y python3-venv python3-apt git

    if ! command -v uv >/dev/null 2>&1; then
        log_pipe "installing uv"
        wget -qO- https://astral.sh/uv/install.sh | sh
        source "$HOME/.local/bin/env"
    fi
}

collect_user_config() {
    echo
    echo "Input user data below:"

    read -p "  Git name: " git_name < /dev/tty
    read -p "  Git email: " git_email < /dev/tty

    while true; do
        echo "  Select target environment:"
        echo "    1) Personal"
        echo "    2) Work"
        echo

        read -r -n 1 -p "  Selection [1-2]: " answer < /dev/tty
        echo

        case "$answer" in
            1) target_env="personal"; break ;;
            2) target_env="work"; break ;;
            *) echo "Wrong selection. Try again." ;;
        esac
    done
}

setup_chezmoi() {
    log_pipe "installing chezmoi"
    wget -qO- https://get.chezmoi.io/lb | sh -s -- init "$TARGET_REPO"
}


write_config() {
    mkdir -p "$CHEZMOIDATA_DIR"

    cat > "$CHEZMOIDATA_DIR/all.yaml" <<EOF
git:
  name: "$git_name"
  email: "$git_email"
target_env: "$target_env"
EOF

    run "$CHEZMOI_BIN" apply

    ln -sf \
        "$CHEZMOIDATA_DIR/all.yaml" \
        "$BOOTSTRAP_DIR/group_vars/all.yaml"
}

run_ansible() {
    run_script 00_install_ansible.bash
    run_script 01_run_ansible.bash
    deactivate 2>/dev/null || true
}

finish() {
    run_script 99_notice.bash
}

# ----------------------------
# Main (declarative flow)
# ----------------------------

main() {
    bootstrap_system
    collect_user_config
    setup_chezmoi
    write_config
    run_ansible
    finish
}

main "$@"
