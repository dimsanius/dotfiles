# ----- functions -----
activate_west_venv(){
    # Activate zephyrproject venv
    source $ZEPHYR_BASE/../.venv/bin/activate
}

custom_west_build_args_old(){
    activate_west_venv
    west build -p -b c159 -- -DEXT_FLASH="$1" 
    deactivate
}

custom_west_flash_args_old()
{
    activate_west_venv
    west flash
    deactivate
}

custom_west_build_args(){
    activate_west_venv
    west build -p always -b aegis
    deactivate
}

custom_west_flash_args(){
    activate_west_venv
    west flash --bin-file $1
    deactivate
}

# ----- aliases -----
# --- west ---
alias wbuild_old=custom_west_build_args_old
alias wflash_old=custom_west_flash_args_old

alias wbuild=custom_west_build_args
alias wflash=custom_west_flash_args

# --- JLink ---
alias jviewer="nohup JLinkRTTViewer > /dev/null 2>&1 &"



# ----- exports -----
# --- python ---
case ":$PATH:" in
    *":/opt/python/3.13.14/bin:"*) ;;
    *) export PATH="/opt/python/3.13.14/bin:$PATH" ;;
esac

# --- Zephyr ---
export ZEPHYR_BASE=$HOME/dev/hav-aegis-tools/zephyrproject/zephyr

# Select either Zephyr SDK Toolchain or ARM Toolchain below

# Zephyr SDK Toolchain
# export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
# export ZEPHYR_SDK_INSTALL_DIR=$HOME/dev/hav-aegis-tools/zephyr-sdk-0.15.2


# ARM Toolchain (newer, not used by CH)
# export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
# export GNUARMEMB_TOOLCHAIN_PATH=$HOME/dev/hav-aegis-tools/arm-gnu-toolchain-12.2.mpacbti-rel1-x86_64-arm-none-eabi

# ARM Toolchain (older, used by CH)
export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
export GNUARMEMB_TOOLCHAIN_PATH=$HOME/dev/hav-aegis-tools/arm-gnu-toolchain-11.3.rel1-x86_64-arm-none-eabi
