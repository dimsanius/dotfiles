#!/bin/bash

say() {
    echo "[Ansible Install] ==> $1"
}

say "Checking Ansible status..."

if [ -d "$HOME/.bootstrap/.venv" ]; then
    say "Ansible found. Deleting it."
    rm -r $HOME/.bootstrap/.venv
fi

say "Installing Ansible"
python3 -m venv $HOME/.bootstrap/.venv
source $HOME/.bootstrap/.venv/bin/activate

say "Installing Ansible dependencies"
pip install -q -r $HOME/.bootstrap/requirements.txt
