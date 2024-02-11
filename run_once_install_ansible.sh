#!/bin/bash

install_python_venv_on_fedora() {
    sudo dnf install -y python3-venv
}

install_python_venv_on_ubuntu() {
    sudo apt -qq update
    sudo apt -qq install -y python3-venv
}

install_python_venv_on_mac() {
    brew install python3-venv
}

get_git_name() {
    while true
    do
        read -p "Enter git name (e.g. John Johnson): " input_git_name

        if [[ $input_git_name =~ ^[a-zA-Z-]+( [a-zA-Z-]+)+$ ]]; then
            # Correct name format
            break
        else
            echo "Incorrect name format. Please try again."
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
            echo "Incorrect name format. Please try again."
        fi
    done
}

OS="$(uname -s)"

echo "Installing python3-venv package"
case "${OS}" in
    Linux*)
        if [ -f /etc/fedora-release ]; then
            install_python_venv_on_fedora
        elif [ -f /etc/lsb-release ]; then
            install_python_venv_on_ubuntu
        else
            echo "Unsupported Linux distribution"
            exit 1
        fi
        ;;
    Darwin*)
        install_python_venv_on_mac
        ;;
    *)
        echo "Unsupported operating system: ${OS}"
        exit 1
        ;;
esac


echo "Creating python venv and installing ansible"
python3 -m venv ~/.bootstrap/.venv --upgrade-deps
source ~/.bootstrap/.venv/bin/activate
pip install -q ansible

echo "Running Ansible..."
ansible-playbook ~/.bootstrap/setup.yml --ask-become-pass
echo "Ansible completed"

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