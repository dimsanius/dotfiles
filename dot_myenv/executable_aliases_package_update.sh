#!/bin/bash

_say() {
    echo "======> $1"
}

apt_package_update() {
    _say "apt package update"
    sudo nala update
    sudo nala upgrade
}

snap_packages_update() {
    _say "snap package update"
    sudo snap refresh
}

omz_update() {
    _say "OMZ update"
    omz update
}

do_update() {
    apt_package_update
    echo
    snap_packages_update
    echo
    omz_update
}

alias package-update=do_update
