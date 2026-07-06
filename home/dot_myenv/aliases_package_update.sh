package-update() {
    run() {
        echo "======> $*"
        "$@" || return
    }

    apt_package_update() {
        run sudo nala update
        echo
        run sudo nala upgrade
    }

    snap_packages_update() {
        run sudo snap refresh
    }

    uv_update() {
        run uv self update
    }

    omz_update() {
        run omz update
    }

    apt_package_update
    echo
    snap_packages_update
    echo
    uv_update
    echo
    omz_update
}
