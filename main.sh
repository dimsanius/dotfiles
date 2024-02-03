#!/bin/bash

# Function to show help message
show_help() {
    cat <<EOF

An installer script to prep the environment.

Usage: $0 [options]

    Options: [ -v|--verbose -h|--help ]

        --verbose           - Make script output verbose
        --help              - Show help and exit

EOF
}

# Function to customise the print
say() {
    [ "$VERBOSE" ] || [ "$2" ] && echo "==> $1"
}

VERBOSE=""

while (("$#")); do
    case "$1" in
    -h | --help)
        show_help
        exit 0
        ;;
    -v | --verbose)
        VERBOSE=1
        shift
        ;;
    *)
        echo "Error: unsupported option $1"
        show_help
        exit 1
        ;;
    esac
done

say "installing apt packages"
sudo apt install -y curl zsh vim terminator \
    gnome-shell-extensions gnome-tweaks \
    neofetch htop stow jq

say "installing oh-my-zsh"
# Preventing ZSH from autostarting and hijacking current terminal session after install
# More available at: https://github.com/ohmyzsh/ohmyzsh/blob/36f444ed7325720ec05f182781ec7d6c9a4d675c/tools/install.sh#L26
RUNZSH="no" CHSH="no" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Removing pesky default zshrc
rm ~/.zshrc

say "installing zsh-syntax-highlighting"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting >/dev/null 2>&1

say "installing zsh-autosuggestions"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions >/dev/null 2>&1

say "installing zsh-auto-notify"
git clone --depth=1 https://github.com/MichaelAquilina/zsh-auto-notify.git ~/.oh-my-zsh/custom/plugins/auto-notify >/dev/null 2>&1

say "installing zsh-you-should-use"
git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use.git ~/.oh-my-zsh/custom/plugins/you-should-use >/dev/null 2>&1

say "installing zsh-completions"
git clone --depth=1 https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions >/dev/null 2>&1

say "installing powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k >/dev/null 2>&1

say "installing vim-plug"
curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


# CD into a directory in case script was run via install.sh
SCRIPT_PATH="$(dirname "$(realpath "$0")")"
cd $SCRIPT_PATH

say "symlinking files"
stow -t ~ files -R

say "clearing font cache"
fc-cache -f -v >/dev/null 2>&1

say "changing default shell to zsh"
sudo chsh -s $(which zsh) $USER


# Since vim addons require both - dotfiles and the vim package itself - depend on both
say "installing vim plugins"
# `vimrc` has to be specified as it is run from shell
# -e -s allow to start vim fully silently
vim -u ~/.vimrc -e -s +PlugInstall +qall


while true
do
read -p "Enter git name (e.g. John Johnson): " input_name

if [[ $input_name =~ ^[a-zA-Z-]+( [a-zA-Z-]+)+$ ]]; then
    # Correct name format
    break
else
    echo "Incorrect name format. Please try again."
fi
done

while true
do

read -p "Enter git email (e.g. john@gmail.com): " input_email
if [[ $input_email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    # Correct email format
    break
else
    echo "Incorrect name format. Please try again."
fi

done

cat > ~/.gituser <<- EOF
# This file must include global user section only.
# Rest of the config can be found at ~/.gitconfig
[user]
    name = $input_name
    email = $input_email
EOF

say "restart terminal for changes to take effect"
say "on next terminal launch, wait for gitstatusd to finish installation"
