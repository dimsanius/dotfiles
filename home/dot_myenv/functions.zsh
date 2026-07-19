package-update() {
    _run() {
        echo "======> $*"
        "$@" || return
    }

    _upgrade_zoxide() {
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

    _run sudo nala update || return
    echo
    _run sudo nala upgrade || return
    echo
    _run sudo snap refresh || return
    echo
    _run uv self update || return
    echo
    _run chezmoi upgrade || return
    echo
    _run omz update || return
    echo
    _run upgrade_oh_my_zsh_custom || return
    echo
    _run _upgrade_zoxide || return
    echo

    unset -f _upgrade_zoxide _run
}