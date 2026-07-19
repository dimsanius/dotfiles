activate_west_venv() {
    source "$ZEPHYR_BASE/../.venv/bin/activate"
}

west_build() {
    activate_west_venv
    west build -p always -b aegis
    deactivate
}

west_flash() {
    activate_west_venv
    west flash --bin-file "$1"
    deactivate
}

west_build_old() {
    activate_west_venv
    west build -p -b c159 -- -DEXT_FLASH="$1"
    deactivate
}

west_flash_old() {
    activate_west_venv
    west flash
    deactivate
}