# dimsanius dotfiles

## Overview

This repo contains environment (e.g. dotfiles, packages, fonts etc.) set for my liking. Feel free to take anything you find useful

## Platform support

Supports Debian-based amd64(x64) systems, that rely on `apt` package manager.

## Environment management

Environment is set-up via [ansible](https://docs.ansible.com/ansible/latest/index.html)

Afterwards, dot-files are managed via [chezmoi](https://www.chezmoi.io/).

## Install using one-line

Following command will install all the deps and environments in one line (will prompt for `sudo` password twice):

```bash
sudo apt -y install python3-venv python3-apt curl && sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply dimsanius
```

## Manual install

### Pre-requisites

Install following pre-requisites:

- `curl`
- `python3-venv`
- `python3-apt`

```bash
sudo apt -y install curl python3-venv python3-apt
```

### Installation

- Run following one-liner to install `chezmoi` that will trigger environment set-up:

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply dimsanius
```

## Adding new files

TODO

## Removing existing files

TODO

## Update existing files

TODO

## TODO

- Try to split setup for headless distros
- Introduce update command
- Finish writing readme
- Add full Zephyr install (including repo clone, zephyr patch, compiler download)
- Add entire workspace clone including venv build
- Install gnome extensions