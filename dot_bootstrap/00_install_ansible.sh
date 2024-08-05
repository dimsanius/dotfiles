#!/bin/bash

say() {
    echo "[Ansible Install] ==> $1"
}

say "Creating Python's virtual environment"
python3 -m venv ~/.bootstrap/.venv
source ~/.bootstrap/.venv/bin/activate

say "Installing pip dependencies"
pip install -q -r ~/.bootstrap/requirements.txt
