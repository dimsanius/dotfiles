# dimsanius dotfiles

Installs environment (e.g. dotfiles, packages, fonts etc.) for the system.

## Requirements

One of the following:

- `curl`
- `wget`
- `fetch`

## Install

Automatic installation on a fresh system is available via:

- `curl`:

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/dimsanius/dotfiles/master/install.sh)"
```

- `wget`:

```shell
sh -c "$(wget -qO- https://raw.githubusercontent.com/dimsanius/dotfiles/master/install.sh)"
```

- `fetch`:

```shell
sh -c "$(fetch -o - https://raw.githubusercontent.com/dimsanius/dotfiles/master/install.sh)"
```

## Adding symlinks

_Assuming that this repo was installed via `install.sh`._

This will add symlinks to the new files (if any) created within `~/.dotfiles/files`:

- Ensure to put new files and/or dotfiles within `~/.dotfiles/files`
- (!!!) Navigate to the repo: `cd ~/.dotfiles`
- Let `stow` create new symlinks:

```shell
stow files
```

## Remove symlinks

_Assuming that this repo was installed via `install.sh`._

- (!!!) Navigate to the repo: `cd ~/.dotfiles`
- Let `stow` remove current symlinks:

```shell
stow -D files
```

- If required - delete or add files from/to `~/.dotfiles/files`
- To recommission symlinks:

```shell
stow files
```

## TODO

- Try to split setup for headless distros
- Introduce --update command to update symlinks
- Update p10k.zsh (run `p10k configure` to generate a new file)
