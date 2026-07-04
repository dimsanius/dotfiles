#!/bin/bash

log() { echo "→ $*" >&2; }
run() { log "$*"; "$@"; }

run uv venv --clear $HOME/.local/share/chezmoi/bootstrap/.venv
run source $HOME/.local/share/chezmoi/bootstrap/.venv/bin/activate

run uv pip install -r $HOME/.local/share/chezmoi/bootstrap/requirements.txt
