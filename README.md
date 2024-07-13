# dimsanius dotfiles

## Overview

This repo contains environment (e.g. dotfiles, packages, fonts etc.) set for my liking. Feel free to take anything you find useful.

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

## Adding/removing/updating files

My preffered way is based on [official chezmoi documentation](https://www.chezmoi.io/user-guide/frequently-asked-questions/usage/):

> 4. Edit the file in your home directory, and then either re-add it by running `chezmoi add $FILE` or `chezmoi re-add`.

## To-do list

- Finish writing readme
- Add entire work-related repo clone (include venv build)
- Add full Zephyr install (including repo clone, zephyr patch, compiler download)
- Install gnome extensions