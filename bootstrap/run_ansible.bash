#!/bin/bash

set -euo pipefail

log() { echo "→ $*" >&2; }
run() { log "$*"; "$@"; }

BOOTSTRAP_DIR="$HOME/.local/share/chezmoi/bootstrap"
ANSIBLE_PLAYBOOK="$BOOTSTRAP_DIR/setup.yml"

max_attempts=3

for current_attempt in $(seq 1 "$max_attempts"); do
    log "[attempt $current_attempt of $max_attempts] Running Ansible..."

    if ANSIBLE_LOCALHOST_WARNING=False \
       ANSIBLE_INVENTORY_UNPARSED_WARNING=False \
       uvx \
        --with-requirements "$BOOTSTRAP_DIR/requirements.txt" \
        --from ansible-core \
        ansible-playbook "$ANSIBLE_PLAYBOOK" \
        --ask-become-pass; then
        # Ansible run succeeded
        log "[attempt $current_attempt of $max_attempts] Ansible completed successfully"
        exit 0
    else
        # Ansible run attempt failed
        log "[attempt $current_attempt of $max_attempts] Attempt $current_attempt failed."
    fi
done

log "All $max_attempts Ansible run attempts failed. Aborting."
exit 1
