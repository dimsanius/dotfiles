#!/bin/bash

say() {
    echo "[Ansible Install] ==> $1"
}

say "(Re-)Creating venv"
uv venv --clear $HOME/.local/share/chezmoi/bootstrap/.venv
source $HOME/.local/share/chezmoi/bootstrap/.venv/bin/activate

say "Installing Ansible dependencies"
uv pip install -r $HOME/.local/share/chezmoi/bootstrap/requirements.txt
