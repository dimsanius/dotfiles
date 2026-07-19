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