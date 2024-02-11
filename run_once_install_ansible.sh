#!/bin/bash

install_on_fedora() {
    # Installing python3-venv package on fedora
    sudo dnf install -y python3-venv
}

install_on_ubuntu() {
    # Installing python3-venv package on ubuntu
    sudo apt -qq update
    sudo apt -qq install -y python3-venv
}

install_on_mac() {
    # Installing python3-venv package on mac
    brew install python3-venv
}

OS="$(uname -s)"


echo "Installing python3-venv package"
case "${OS}" in
    Linux*)
        if [ -f /etc/fedora-release ]; then
            install_on_fedora
        elif [ -f /etc/lsb-release ]; then
            install_on_ubuntu
        else
            echo "Unsupported Linux distribution"
            exit 1
        fi
        ;;
    Darwin*)
        install_on_mac
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

