#!/bin/bash

set -euo pipefail

log() { echo "→ $*" >&2; }
run() { log "$*"; "$@"; }

BOOTSTRAP_DIR="$HOME/.local/share/chezmoi/bootstrap"
ANSIBLE_PLAYBOOK="$BOOTSTRAP_DIR/setup.yml"

for attempt in 1 2 3; do
    log "[try $retries of 3] Running Ansible..."

    if ANSIBLE_LOCALHOST_WARNING=False \
       ANSIBLE_INVENTORY_UNPARSED_WARNING=False \
       uvx \
        --with-requirements "$BOOTSTRAP_DIR/requirements.txt" \
        --from ansible-core \
        ansible-playbook "$ANSIBLE_PLAYBOOK" \
        --ask-become-pass; then
        # Ansible run succeeded
        log "Ansible completed successfully."
        exit 0
    else
        # Ansible run attempt failed
        log "Attempt $attempt failed."
    fi
done

log "Ansible failed after 3 attempts."
exit 1
