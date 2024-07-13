#!/bin/bash

say() {
    echo "==> $1"
}

say "Creating python venv and installing ansible"
python3 -m venv ~/.bootstrap/.venv --upgrade-deps
source ~/.bootstrap/.venv/bin/activate
pip install -q ansible

retries=1
while [ "$retries" -le 3 ]; do

    say "[try $retries of 3] Running Ansible..."
    if ANSIBLE_LOCALHOST_WARNING=False ANSIBLE_INVENTORY_UNPARSED_WARNING=False ansible-playbook ~/.bootstrap/setup.yml --ask-become-pass --ask-vault-pass; then
        # Command finished successfully
        say "Ansible completed successfully"
        break
    else
        return_code=$?
        if [ "$return_code" -eq 99 ]; then
            say "User interrupted. Aborting install."
            break
        fi
        # Failed for whatever other reason. Try to retry.
        retries=$((retries + 1))
    fi
done

if [ "$retries" -eq 4 ]; then
    say "Ansible failed"
fi

deactivate
