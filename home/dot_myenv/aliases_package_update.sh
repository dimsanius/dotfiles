package-update() {
    run() {
        echo "======> $*"
        "$@" || return
    }
    run sudo nala update || return
    echo
    run sudo nala upgrade || return
    echo
    run sudo snap refresh || return
    echo
    run uv self update || return
    echo
    run chezmoi upgrade || return
    echo
    run omz update || return
    echo
    run upgrade_oh_my_zsh_custom || return

}
