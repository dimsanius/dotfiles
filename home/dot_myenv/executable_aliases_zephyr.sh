#!/bin/bash

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

alias wbuild_old=custom_west_build_args_old

alias wflash_old=custom_west_flash_args_old

alias wbuild=custom_west_build_args

alias wflash=custom_west_flash_args

alias jviewer="nohup JLinkRTTViewer > /dev/null 2>&1 &"
