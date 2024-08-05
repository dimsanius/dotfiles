#!/bin/bash

say() {
    echo "[Ansible Install] ==> $1"
}

say "Checking Ansible status..."

if [ -d "~/.bootstrap/.venv" ]; then
    say "Ansible found. Deleting it."
    rm -r venv ~/.bootstrap/.venv
fi

say "Installing Ansible"
python3 -m venv ~/.bootstrap/.venv
source ~/.bootstrap/.venv/bin/activate

say "Installing Ansible dependencies"
pip install -q -r ~/.bootstrap/requirements.txt
