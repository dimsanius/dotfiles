# dimsanius dotfiles

## Overview

This repo contains environment (e.g. dotfiles, packages, fonts etc.) set for my liking.

## Description

- Platform support: `amd64 (x64)`
- Target OS: `Ubuntu 24.04 LTS`
- Target package manager: `apt`

In a nutshell:

- Environment is set-up via [ansible](https://docs.ansible.com/ansible/latest/index.html)
- Dot-files are managed via [chezmoi](https://www.chezmoi.io/).

## Install via SSH (recommended)

:warning: Ensure to generate a new set of SSH keys and add it to this GitHub account. :warning:

Following command will install all the deps and environments (will prompt for `sudo` password twice):

```bash
wget -qO- https://raw.githubusercontent.com/dimsanius/dotfiles/main/bootstrap.sh | sh
```

## Install via HTTPS

Following command will install all the deps and environments (will prompt for `sudo` password twice):

```bash
wget -qO- https://raw.githubusercontent.com/dimsanius/dotfiles/main/bootstrap.sh | BOOTSTRAP_HTTPS=1 sh
```

<details><summary>Manual install</summary>

### Pre-requisites

Update `apt` list:

```bash
sudo apt update
```

Install following pre-requisites:

- `python3-venv`
- `python3-apt`
- `git`

```bash
sudo apt -y install python3-venv python3-apt
```

### Install & run via SSH (recommended)

⚠️ Ensure to generate a new set of SSH keys and add it to this GitHub account. ⚠️

- Run following one-liner to install `chezmoi` that will trigger environment set-up:

```bash
wget -qO- https://get.chezmoi.io/lb | sh -s -- init --apply git@github.com:dimsanius/dotfiles.git
```

### Install & run via HTTPS

- Run following one-liner to install `chezmoi` that will trigger environment set-up:

```bash
wget -qO- https://get.chezmoi.io/lb | sh -s -- init --apply https://github.com/dimsanius/dotfiles.git
```

</details>

## Adding/removing/updating files

My preffered way is based on [official chezmoi documentation](https://www.chezmoi.io/user-guide/frequently-asked-questions/usage/):

> 1. Edit the file in your home directory, and then either re-add it by running `chezmoi add $FILE` or `chezmoi re-add`.

## TODO

- [ ] Ensure appropriate Python version is selected
- [ ] Remove exact version pin from JetBrains Toolbox
- [ ] Ensure .env_selector is updated (have a look at chezmoi templates: <https://www.chezmoi.io/user-guide/templating/>)
- [ ] Improve personal vs work env handling altogether
- [ ] Ensure Jetbrains Toolbox requirements are satisfied (<https://www.jetbrains.com/help/toolbox-app/installation.html>)
- [ ] Install uv within ansible as well (consider skipping install from script if already present)
- [ ] Change preffered apprach as it is different
- [ ] Install Slack via *.deb package
