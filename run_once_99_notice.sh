#!/bin/bash

say() {
    echo "==> $1"
}

for a in `seq 20`; do echo -n _; done; echo
say "Re-login into your system for changes to take effect."
say "On next terminal launch, wait for powerlevel10k to fetch gitstatusd."
