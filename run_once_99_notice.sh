#!/bin/bash

say() {
    echo "==> $1"
}

for a in `seq 20`; do echo -n _; done; echo
say "Restart terminal for changes to take effect."
say "On next terminal launch, wait for powerlevel10k to fetch gitstatusd."
