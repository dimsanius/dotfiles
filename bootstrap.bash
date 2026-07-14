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
    run sudo apt -qqq update
    run sudo apt -qqq install -y git

    if ! command -v uv >/dev/null 2>&1 || ! command -v uvx >/dev/null 2>&1; then
        log "installing uv"
        wget -qO- https://astral.sh/uv/install.sh | UV_QUITE=1 sh
        source "$HOME/.local/bin/env"
    fi
}

collect_user_config() {
    echo
    log "Input user data below:"

    while true; do
        read -p "  Git name: " git_name < /dev/tty

        if [[ -n "${git_name//[[:space:]]/}" ]]; then
            break
        fi

        log "Git name cannot be empty."
    done

    while true; do
        read -p "  Git email: " git_email < /dev/tty

        if [[ "$git_email" =~ ^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$ ]]; then
            break
        fi

        log "Please enter a valid email address."
    done

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

install_chezmoi() {
    if ! command -v chezmoi >/dev/null 2>&1;then
        cd "$HOME"
        log "installing chezmoi"
        wget -qO- https://get.chezmoi.io/lb | sh -s -- init "$TARGET_REPO"
    fi
}


write_config() {
    run uvx --from jinja2-cli jinja2 \
        "$CHEZMOI_DIR/templates/git_user.yml.j2" \
        -D git_name="$git_name" \
        -D git_email="$git_email" \
        -o "$CHEZMOIDATA_DIR/git_user.yml"
    
    run uvx --from jinja2-cli jinja2 \
        "$CHEZMOI_DIR/templates/target_env.yml.j2" \
        -D target_env="$target_env" \
        -o "$CHEZMOIDATA_DIR/target_env.yml"

    run ln -sf \
        "$CHEZMOIDATA_DIR/target_env.yml" \
        "$BOOTSTRAP_DIR/group_vars/all.yml"
}

apply_chezmoi() {
    run "$CHEZMOI_BIN" apply
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
    old_shell="$(getent passwd "$USER" | cut -d: -f7)"

    bootstrap_system
    collect_user_config
    install_chezmoi
    write_config
    apply_chezmoi
    run_script run_ansible.bash

    new_shell="$(getent passwd "$USER" | cut -d: -f7)"

    if [[ "$old_shell" != "$new_shell" ]]; then
        final_notice
    fi
}

main "$@"
