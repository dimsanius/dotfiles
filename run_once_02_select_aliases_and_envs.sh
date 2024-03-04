#!/bin/bash

say() {
    echo "==> $1"
}

echo "\$HOME/.myenv/aliases_batcat.sh" >> $HOME/.included_envs.sh
echo "\$HOME/.myenv/aliases_exa.sh" >> $HOME/.included_envs.sh
echo "\$HOME/.myenv/env_zoxide.sh" >> $HOME/.included_envs.sh



read -p "==> Include Zephyr env and aliases? (Y/n) " response

case "$response" in
    [Yy]) 
        say "Zephyr env and aliases will be included"
        echo "\$HOME/.myenv/aliases_zephyr.sh" >> $HOME/.included_envs.sh
        echo "\$HOME/.myenv/env_zephyr.sh" >> $HOME/.included_envs.sh
    *)
        say "Zephyr env and aliases will not be included"
        ;;
esac