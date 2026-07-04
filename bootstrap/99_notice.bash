#!/bin/bash

log() { echo "→ $*" >&2; }
run() { log "$*"; "$@"; }

for a in `seq 20`; do echo -n _; done; echo
log "Re-login into your system for changes to take effect."
log "On next terminal launch, wait for powerlevel10k to fetch gitstatusd."
