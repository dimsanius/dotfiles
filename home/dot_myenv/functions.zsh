package-update() {
    run() {
        echo "======> $*"
        "$@" || return
    }

    upgrade_zoxide() {
        local current latest

        current=$(zoxide --version | awk '{print $2}')
        latest=$(
            curl -fsSL https://api.github.com/repos/ajeetdsouza/zoxide/releases/latest |
            jq -r '.tag_name | ltrimstr("v")'
        )

        if [[ "$(printf '%s\n%s\n' "$current" "$latest" | sort -V | tail -1)" != "$current" ]]; then
            echo "Updating zoxide $current -> $latest..."
            curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
        else
            echo "zoxide: already at the latest version ($current)"
        fi
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
    echo
    run upgrade_zoxide || return
    echo

    unset -f upgrade_zoxide run
}