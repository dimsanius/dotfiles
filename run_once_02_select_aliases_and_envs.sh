#!/bin/bash

say() {
    echo "==> $1"
}

env_selector_file="$HOME/.env_selector.sh"

if [ -f $env_selector_file ]; then
    # Remove the file if it already exists
    rm $env_selector_file
fi

# Include this always
echo "source \$HOME/.myenv/aliases_batcat.sh" >>$env_selector_file
echo "source \$HOME/.myenv/aliases_eza.sh" >>$env_selector_file
echo "source \$HOME/.myenv/env_zoxide.sh" >>$env_selector_file
echo "source \$HOME/.myenv/env_chezmoi.sh" >>$env_selector_file
echo "source \$HOME/.myenv/env_fzf.sh" >>$env_selector_file
echo "source \$HOME/.myenv/env_fzf_completion.zsh" >>$env_selector_file
echo "source \$HOME/.myenv/env_fzf_key_bindings.zsh" >>$env_selector_file

# Include this ocassionally
while true; do
    read -p "==> Include Zephyr env and aliases? [Y/n] " yn
    case $yn in
    [Yy]*)
        say "Zephyr env and aliases will be included"
        echo "source \$HOME/.myenv/aliases_zephyr.sh" >>$env_selector_file
        echo "source \$HOME/.myenv/env_zephyr.sh" >>$env_selector_file
        break
        ;;
    [Nn]*)
        say "Zephyr env and aliases will not be included"
        break
        ;;
    *)
        say "Incorrect input. Please, try again"
        ;;
    esac
done
