#!/bin/bash

say() {
    echo "==> $1"
}

chmod +x $HOME/.myenv/*.sh

# Include this always
echo "source \$HOME/.myenv/aliases_batcat.sh" >> $HOME/.included_envs.sh
echo "source \$HOME/.myenv/aliases_exa.sh" >> $HOME/.included_envs.sh
echo "source \$HOME/.myenv/env_zoxide.sh" >> $HOME/.included_envs.sh

# Include this ocassionally
while true; do
    read -p "==> Include Zephyr env and aliases? [Y/n] " yn
    case $yn in
        [Yy]* ) 
            say "Zephyr env and aliases will be included"
            echo "source \$HOME/.myenv/aliases_zephyr.sh" >> $HOME/.included_envs.sh
            echo "source \$HOME/.myenv/env_zephyr.sh" >> $HOME/.included_envs.sh
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