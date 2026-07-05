#!/bin/bash

log() { echo "→ $*" >&2; }
run() { log "$*"; "$@"; }

PLAYBOOK="$HOME/.local/share/chezmoi/bootstrap/setup.yml"

retries=1
while [ "$retries" -le 3 ]; do

    log "[try $retries of 3] Running Ansible..."

    if ANSIBLE_LOCALHOST_WARNING=False \
       ANSIBLE_INVENTORY_UNPARSED_WARNING=False \
       uvx \
        --with "ansible==14.1.0" \
        --from ansible-core \
        ansible-playbook "$PLAYBOOK" \
        --ask-become-pass; then
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
