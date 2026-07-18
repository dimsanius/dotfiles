# ==============================================================================
# Zephyr environment
# ==============================================================================

# Python
case ":$PATH:" in
    *":/opt/python/3.13.14/bin:"*) ;;
    *) export PATH="/opt/python/3.13.14/bin:$PATH" ;;
esac

# Zephyr
export ZEPHYR_BASE="$HOME/dev/hav-aegis-tools/zephyrproject/zephyr"

# Toolchain selection
#
# Zephyr SDK
# export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
# export ZEPHYR_SDK_INSTALL_DIR="$HOME/dev/hav-aegis-tools/zephyr-sdk-0.15.2"

# ARM Toolchain (newer, not used by CH)
# export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
# export GNUARMEMB_TOOLCHAIN_PATH="$HOME/dev/hav-aegis-tools/arm-gnu-toolchain-12.2.mpacbti-rel1-x86_64-arm-none-eabi"

# ARM Toolchain (older, used by CH)
export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
export GNUARMEMB_TOOLCHAIN_PATH="$HOME/dev/hav-aegis-tools/arm-gnu-toolchain-11.3.rel1-x86_64-arm-none-eabi"


# ==============================================================================
# Zephyr helpers
# ==============================================================================

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


# ==============================================================================
# Legacy Zephyr helpers
# ==============================================================================

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


# ==============================================================================
# Shortcuts
# ==============================================================================

alias wbuild=west_build
alias wflash=west_flash

alias wbuild_old=west_build_old
alias wflash_old=west_flash_old

alias jviewer='nohup JLinkRTTViewer >/dev/null 2>&1 &'