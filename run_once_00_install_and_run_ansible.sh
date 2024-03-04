#!/bin/bash

say() {
    echo "==> $1"
}

say "Creating python venv and installing ansible"
python3 -m venv ~/.bootstrap/.venv --upgrade-deps
source ~/.bootstrap/.venv/bin/activate
pip install -q ansible

say "Running Ansible..."
ANSIBLE_LOCALHOST_WARNING=False ANSIBLE_INVENTORY_UNPARSED_WARNING=False ansible-playbook ~/.bootstrap/setup.yml --ask-become-pass
say "Ansible completed"

deactivate
