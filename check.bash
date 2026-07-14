#!/bin/bash

set -euo pipefail

log() {
    echo "→ $*" >&2
}

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$ROOT_DIR"

log "Checking dependencies"

if ! command -v uv >/dev/null 2>&1; then
    echo "Error: uv is required but not installed." >&2
    exit 1
fi

if ! command -v shellcheck >/dev/null 2>&1; then
    echo "Error: shellcheck is required but not installed." >&2
    exit 1
fi

if ! command -v shfmt >/dev/null 2>&1; then
    echo "Error: shfmt is required but not installed." >&2
    exit 1
fi

log "Running ansible-lint"
(
    cd bootstrap
    uvx --with-requirements=requirements_dev.txt ansible-lint setup.yml
)

cd "$ROOT_DIR"
log "Running shellcheck"
shellcheck bootstrap.bash bootstrap/run_ansible.bash

cd "$ROOT_DIR"
log "Running shfmt"
shfmt -l -d -i 4 bootstrap.bash bootstrap/run_ansible.bash

log "Running j2lint"
uvx --with-requirements=bootstrap/requirements_dev.txt j2lint templates

log "All checks passed"