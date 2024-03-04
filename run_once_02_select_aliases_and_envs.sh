#!/bin/bash

say() {
    echo "==> $1"
}

chmod +x $HOME/.myenv/*.sh

env_selector_file="$HOME/.env_selector.sh"

# Include this always
echo "source \$HOME/.myenv/aliases_batcat.sh" >> $env_selector_file
echo "source \$HOME/.myenv/aliases_exa.sh" >> $env_selector_file
echo "source \$HOME/.myenv/env_zoxide.sh" >> $env_selector_file

# Include this ocassionally
while true; do
    read -p "==> Include Zephyr env and aliases? [Y/n] " yn
    case $yn in
        [Yy]* ) 
            say "Zephyr env and aliases will be included"
            echo "source \$HOME/.myenv/aliases_zephyr.sh" >> $env_selector_file
            echo "source \$HOME/.myenv/env_zephyr.sh" >> $env_selector_file
            break
            ;;
        [Nn]* ) 
            say "Zephyr env and aliases will not be included"
            break
            ;;
        * ) 
            say "Incorrect input. Please, try again"
            ;;
    esac
done