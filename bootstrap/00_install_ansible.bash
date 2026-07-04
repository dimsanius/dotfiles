#!/bin/bash

log() { echo "→ $*" >&2; }
run() { log "$*"; "$@"; }

log "(Re-)Creating venv"
run venv --clear $HOME/.local/share/chezmoi/bootstrap/.venv
run source $HOME/.local/share/chezmoi/bootstrap/.venv/bin/activate

log "Installing Ansible dependencies"
run pip install -r $HOME/.local/share/chezmoi/bootstrap/requirements.txt
