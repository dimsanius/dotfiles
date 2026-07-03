#!/bin/bash

say() {
    echo "[Ansible Install] ==> $1"
}

say "Checking venv status..."

if [ -d "$HOME/.bootstrap/.venv" ]; then
    say "venv found. Deleting it."
    rm -r $HOME/.bootstrap/.venv
fi

say "Creating venv"
uv venv $HOME/.bootstrap/.venv
source $HOME/.bootstrap/.venv/bin/activate

say "Installing Ansible dependencies"
uv pip install -q -r $HOME/.bootstrap/requirements.txt
