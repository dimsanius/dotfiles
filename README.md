# dimsanius dotfiles

Installs environment (e.g. dotfiles, packages, fonts etc.) for the system.

## Automatic install using one-line

Following command will install all the deps and environments in one line:

```bash
sudo apt -y install python3-venv python3-apt curl && sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply dimsanius
```

## Manual install

### Requirements

Install following requirements:

- `python3-venv`
- `python3-apt`
- `curl`

```bash
sudo apt -y install python3-venv python3-apt curl
```

### Installation

- Run following one-liner to install `chezmoi` and all the environment:

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
- Introduce --update command to update symlinks
