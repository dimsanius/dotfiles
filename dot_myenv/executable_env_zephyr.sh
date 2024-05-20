#!/bin/bash

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
