#!/bin/bash

usage() {
    cat << NOTICE
    OPTIONS
    -h  show this message
    -v  print verbose info
    -p  install programs (apt)
    -i  install dotfiles
    -t  install theme
NOTICE
}

say() {
    [ "$VERBOSE" ] || [ "$2" ] && echo "==> $1"
}

if [ -z "${HOME:-}" ]; then
    HOME="$(cd ~ && pwd)"
fi

PROJ_DIR=$(cd $(dirname "${0}") && pwd)

FILES=(
    "terminator"
    "vimrc"
    "zshrc"
    "p10k.zsh"
)

PATHS=(
    "${HOME}/.config/terminator/config"
    "${HOME}/.vimrc"
    "${HOME}/.zshrc"
    "${HOME}/.p10k.zsh"
)

VERBOSE=""
INSTALL=""
INSTALL_THEME=""
INSTALL_PROGRAMS=""

while getopts hvpit opts; do
    case ${opts} in
        h) usage && exit 0 ;;
        v) VERBOSE=1 ;;
        i) INSTALL=1 ;;
        p) INSTALL_PROGRAMS=1 ;;
        t) INSTALL_THEME=1 ;;
        *) ;;
    esac
done

if [ "$INSTALL_PROGRAMS" ]; then
    say "installing apt programs"
    sudo apt install curl git zsh vim terminator \
        gnome-shell-extensions gnome-tweaks \
        neofetch htop

    say "installing oh-my-zsh"
    # Preventing ZSH from autostarting and hijacking current terminal session after install
    RUNZSH="no" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    say "installing vim-plug"
    curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    say "installing zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting > /dev/null 2>&1

    say "installing zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions > /dev/null 2>&1

    say "installing zsh-auto-notify"
    git clone https://github.com/MichaelAquilina/zsh-auto-notify.git ~/.oh-my-zsh/custom/plugins/auto-notify > /dev/null 2>&1

    say "installing zsh-you-should-use"
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ~/.oh-my-zsh/custom/plugins/you-should-use > /dev/null 2>&1

    say "installing zsh-completions"
    git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions > /dev/null 2>&1

    say "installing powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k > /dev/null 2>&1

    say "installing meslo font"
    mkdir -p ~/.local/share/fonts/
    # This ensures path is read and known regardless of the way of invoking script - directly or via `install.sh`
    CURRENT_DIR=$(dirname -- "$( readlink -f -- "$0" )")
    cp $CURRENT_DIR/fonts/*.ttf ~/.local/share/fonts/

    say "clearing font cache"
    fc-cache -f -v > /dev/null 2>&1
fi

if [ "$INSTALL" ]; then
    for INDEX in "${!FILES[@]}"; do
        if [ ! -d "$(dirname "${PATHS[$INDEX]}")" ]; then
            mkdir -p "$(dirname "${PATHS[$INDEX]}")"
        fi
        if [ -f "${PATHS[$INDEX]}" ]; then
            mv "${PATHS[$INDEX]}" "${PATHS[$INDEX]}.backup"
        fi
        ln -s "${PROJ_DIR}/files/${FILES[$INDEX]}" "${PATHS[$INDEX]}"
    done

    read -p "Enter git email: " input_email
    read -p "Enter git name: " input_name

    cat > ~/.gitconfig <<- EOF
[user]
    email = $input_email
    name = $input_name
[alias]
    lo = log --all --branches --tags --remotes --decorate --graph --oneline --pretty=format:'%C(yellow)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
    subupdate = submodule foreach git pull origin master
[push]
    autoSetupRemote = true
[fetch]
    prune = true
EOF
fi

if [ "$INSTALL_PROGRAMS" ] && [ "$INSTALL" ]; then
    say "installing vim plugins"
    # `vimrc` has to be specified as it is run from shell
    # -e -s allow to start vim fully silently
    vim -u ~/.vimrc -e -s +PlugInstall +qall

    say "restart terminal for changes to take effect"
    say "on next terminal launch, wait for gitstatusd to finish installation"
fi     

if [ "$INSTALL_THEME" ]; then
    git clone https://github.com/robertalexa/gtk-theme-framework.git ~/.misc/gtk-theme-framework
    ~/.misc/gtk-theme-framework/main.sh -t oceanic -iosvc
fi
