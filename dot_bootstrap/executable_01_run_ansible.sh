#!/bin/bash

say() {
    echo "[Ansible Run] ==> $1"
}

source ~/.bootstrap/.venv/bin/activate

while true; do
    say "Environment selection:"
    echo " 1. Personal"
    echo " 2. Work"
    echo ""
    read -p " Selection [1-2]: " -n 1 answer
    echo ""
    echo ""

    if [[ "$answer" == 1 ]]; then
        environment="personal"
        break
    fi

    if [[ "$answer" == 2 ]]; then
        environment="work"
        break
    fi

    echo "Wrong selection. Try again."
done

retries=1
while [ "$retries" -le 3 ]; do

    say "[try $retries of 3] Running Ansible..."
    if ANSIBLE_LOCALHOST_WARNING=False ANSIBLE_INVENTORY_UNPARSED_WARNING=False ansible-playbook ~/.bootstrap/setup.yml --ask-become-pass --ask-vault-pass --extra-vars "environment_type=$environment"; then
        # Ansible run succeeded
        say "Ansible compeleted successfully."
        break
    else
        # Ansible run failed. Consume try attempt
        retries=$((retries + 1))
    fi
done

if [ "$retries" -eq 4 ]; then
    say "Ansible failed to complete."
fi
