#!/bin/bash

say() {
    echo "[Ansible Install] ==> $1"
}

say "(Re-)Creating venv"
uv venv --clear $HOME/.bootstrap/.venv
source $HOME/.bootstrap/.venv/bin/activate

say "Installing Ansible dependencies"
uv pip install -r $HOME/.bootstrap/requirements.txt
