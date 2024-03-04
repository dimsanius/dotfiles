#!/bin/bash

get_git_name() {
    while true
    do
        read -p "Enter git name (e.g. John Johnson): " input_git_name

        if [[ $input_git_name =~ ^[a-zA-Z-]+( [a-zA-Z-]+)+$ ]]; then
            # Correct name format
            break
        else
            say "Incorrect name format. Please try again."
        fi
    done
}

get_git_email() {
    while true
    do
        read -p "Enter git email (e.g. john@gmail.com): " input_git_email
        if [[ $input_git_email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
            # Correct email format
            break
        else
            say "Incorrect email format. Please try again."
        fi
    done
}

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

get_git_name
get_git_email

cat > ~/.gituser <<- EOF
# This file must include only global user section.
# Rest of the global config should be located at ~/.gitconfig
[user]
    name = $input_git_name
    email = $input_git_email
EOF


say "restart terminal for changes to take effect"
say "on next terminal launch, wait for gitstatusd to finish installation"