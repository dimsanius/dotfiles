# dimsanius dotfiles

Installs environment (e.g. dotfiles, packages, fonts etc.) for the system.

## Requirements

Install following requirements manually:

- `python3-venv`
- `python3-apt`
- `curl`

```bash
sudo apt install python3-venv python3-apt curl
```

## Installation

- Run following one-liner:

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
