# dimsanius dotfiles

## Overview

This repo contains environment (e.g. dotfiles, packages, fonts etc.) set for my liking.

## Install via SSH (recommended)

:warning: Ensure to have a valid SSH key :warning:

Following command will install all the deps and environments (will prompt for `sudo` password twice):

```bash
wget -qO- https://raw.githubusercontent.com/dimsanius/dotfiles/main/bootstrap.bash | bash
```

## Install via HTTPS

Following command will install all the deps and environments (will prompt for `sudo` password twice):

```bash
wget -qO- https://raw.githubusercontent.com/dimsanius/dotfiles/main/bootstrap.bash | BOOTSTRAP_HTTPS=1 bash
```

## Description

- Platform support: `amd64 (x64)`
- Target OS: `Ubuntu 24.04 LTS`
- Target package manager: `apt`

In a nutshell:

- Dot-files are managed via [chezmoi](https://www.chezmoi.io/)
- Environment is set-up via [ansible](https://docs.ansible.com/ansible/latest/index.html)

During the first-install, you will be prompted to specify some details: 

- Git details, such as user name and user email
- Target setup environment

These details will be templated as following to `chezmoi`:
- Git details: from `template/git_user.yml.j2` to `home/.chezmoidata/git_user.yml`.
- Target setup environment: from `template/target_env.yml.j2` to `home/.chezmoidata/target_env.yml`.

Afterwards, target setup environment will be symlinked from `chezmoi` to `ansible`:
- From `home/.chezmoidata/target_env.yml` to `bootstrap/group_vars/all.yml`

## Adding/removing/updating dotfiles

My preffered way is based on [official chezmoi documentation](https://www.chezmoi.io/user-guide/frequently-asked-questions/usage/):

> 2. Use `chezmoi cd` and edit the files in the source directory directly. Run `chezmoi diff` to see what changes would be made, and `chezmoi apply` to make the changes.

## TODO

None
