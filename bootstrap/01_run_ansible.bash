#!/bin/bash

log() { echo "→ $*" >&2; }
run() { log "$*"; "$@"; }

run source $HOME/.local/share/chezmoi/bootstrap/.venv/bin/activate

retries=1
while [ "$retries" -le 3 ]; do

    log "[try $retries of 3] Running Ansible..."
    if ANSIBLE_LOCALHOST_WARNING=False ANSIBLE_INVENTORY_UNPARSED_WARNING=False ansible-playbook $HOME/.local/share/chezmoi/bootstrap/setup.yml --ask-become-pass; then
        # Ansible run succeeded
        log "Ansible compeleted successfully."
        break
    else
        # Ansible run failed. Consume try attempt
        retries=$((retries + 1))
    fi
done

if [ "$retries" -eq 4 ]; then
    log "Ansible failed to complete."
fi
