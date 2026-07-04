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

:warning: Ensure to add an SSH key. :warning:

Following command will install all the deps and environments (will prompt for `sudo` password twice):

```bash
wget -qO- https://raw.githubusercontent.com/dimsanius/dotfiles/main/bootstrap.bash | bash
```

## Install via HTTPS

Following command will install all the deps and environments (will prompt for `sudo` password twice):

```bash
wget -qO- https://raw.githubusercontent.com/dimsanius/dotfiles/main/bootstrap.bash | BOOTSTRAP_HTTPS=1 bash
```

## Adding/removing/updating files

My preffered way is based on [official chezmoi documentation](https://www.chezmoi.io/user-guide/frequently-asked-questions/usage/):

> 2. Use `chezmoi cd` and edit the files in the source directory directly. Run `chezmoi diff` to see what changes would be made, and `chezmoi apply` to make the changes.

## TODO

- [ ] Install Slack via *.deb package
- [ ] Prevent install if chezmoi is already present
