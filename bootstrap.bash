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

run_script() {
    source "$BOOTSTRAP_DIR/$1"
}

# ----------------------------
# Stages
# ----------------------------

bootstrap_system() {
    run sudo apt update
    run sudo apt install -y git

    if ! command -v uv >/dev/null 2>&1 || ! command -v uvx >/dev/null 2>&1; then
        log "installing uv"
        wget -qO- https://astral.sh/uv/install.sh | sh
        source "$HOME/.local/bin/env"
    fi
}

abort_if_chezmoi_present() {
    if [ -f "$CHEZMOI_BIN" ];then
        log "found chezmoi at '$CHEZMOI_BIN'. Checking chezmoi status..."
        if [[ "$("$CHEZMOI_BIN" source-path)" == "$CHEZMOI_DIR/home" ]]; then
            log "'$CHEZMOI_DIR/home' exists and is sourced. Aborting further chezmoi operations."
            exit 0
        fi
        log "chezmoi exists but is not initialised. Continuing operations."
    fi
}

collect_user_config() {
    echo
    log "Input user data below:"

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
            *) log "Wrong selection. Try again." ;;
        esac
    done
}

setup_chezmoi() {
    log "installing chezmoi"
    wget -qO- https://get.chezmoi.io/lb | sh -s -- init "$TARGET_REPO"
}


write_config() {
    mkdir -p "$CHEZMOIDATA_DIR"

    uvx --from jinja2-cli jinja2 \
        "$CHEZMOI_DIR/templates/git_user.yml.j2" \
        -D git_name="$git_name" \
        -D git_email="$git_email" \
        -o "$CHEZMOIDATA_DIR/git_user.yml"
    
    uvx --from jinja2-cli jinja2 \
        "$CHEZMOI_DIR/templates/target_env.yml.j2" \
        -D target_env="$target_env" \
        -o "$CHEZMOIDATA_DIR/target_env.yml"

    run "$CHEZMOI_BIN" apply

    ln -sf \
        "$CHEZMOIDATA_DIR/target_env.yml" \
        "$BOOTSTRAP_DIR/group_vars/all.yml"
}

final_notice() {
    for a in `seq 20`; do echo -n _; done; echo
    log "Re-login into your system for changes to take effect."
    log "On next terminal launch, wait for powerlevel10k to fetch gitstatusd."
}

# ----------------------------
# Main (declarative flow)
# ----------------------------

main() {
    bootstrap_system
    abort_if_chezmoi_present
    collect_user_config
    setup_chezmoi
    write_config
    run_script run_ansible.bash
    final_notice
}

main "$@"
