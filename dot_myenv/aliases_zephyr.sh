activate_west_venv(){
    # Activate zephyrproject venv
    source $ZEPHYR_BASE/../.venv/bin/activate
}


custom_west_build_args(){
    # Pass custom args into west build
    activate_west_venv
    west build -p -b c159 -- -DEXT_FLASH="$1" 
    deactivate
}


# Alisaing west flash
custom_west_flash_args()
{
    activate_west_venv
    west flash
    deactivate
}

alias wbuild=custom_west_build_args

alias wflash=custom_west_flash_args

alias jviewer="nohup JLinkRTTViewer > /dev/null 2>&1 &"