# dimsanius dotfiles

## Overview

This repo contains environment (e.g. dotfiles, packages, fonts etc.) set for my liking.

## Description

Platform support: amd64 (x64), Debian-based systems

Target package manager: `apt`

In a nutshell:
 - Environment is set-up via [ansible](https://docs.ansible.com/ansible/latest/index.html)
 - Dot-files are managed via [chezmoi](https://www.chezmoi.io/).

## One-line install via SSH (recommended)

:warning: Ensure to generate a new set of SSH keys and add it to this GitHub account. :warning:

Following command will install all the deps and environments in one line (will prompt for `sudo` password twice):

```bash
sudo apt update && sudo apt install -y python3-venv python3-apt curl git && sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply git@github.com:dimsanius/dotfiles.git
```

## One-line install via HTTPS

Following command will install all the deps and environments in one line (will prompt for `sudo` password twice):

```bash
sudo apt update && sudo apt install -y python3-venv python3-apt curl git && sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply https://github.com/dimsanius/dotfiles.git
```

<details><summary>Manual install</summary>

### Pre-requisites

Update `apt` list:
```bash
sudo apt update
```

Install following pre-requisites:

- `curl`
- `python3-venv`
- `python3-apt`
- `git`

```bash
sudo apt -y install curl python3-venv python3-apt
```

### Install & run via SSH (recommended)

⚠️ Ensure to generate a new set of SSH keys and add it to this GitHub account. ⚠️

- Run following one-liner to install `chezmoi` that will trigger environment set-up:

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply git@github.com:dimsanius/dotfiles.git
```

### Install & run via HTTPS

- Run following one-liner to install `chezmoi` that will trigger environment set-up:

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply https://github.com/dimsanius/dotfiles.git
```


</details>

## Adding/removing/updating files

My preffered way is based on [official chezmoi documentation](https://www.chezmoi.io/user-guide/frequently-asked-questions/usage/):

> 4. Edit the file in your home directory, and then either re-add it by running `chezmoi add $FILE` or `chezmoi re-add`.
