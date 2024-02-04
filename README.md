# dimsanius dotfiles

Installs environment (e.g. dotfiles, packages, fonts etc.) for the system.

## Requirements

One of the following:

- `curl`
- `wget`
- `fetch`

## Fresh install

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

## Adding/modifying files

Assuming that this repo was installed via `install.sh`:

- Ensure to put updated/new files and/or dotfiles within `~/.dotfiles/files`
- (!!!) Navigate to the repo: `cd ~/dotfiles`
- Update symlinks:

```shell
stow -t ~ files -R
```

- Check updated symlinks
- If no errors - push changes to remote

## TODO

- Try to split setup for headless distros
- Introduce --update command to update symlinks
- Update p10k.zsh (run `p10k configure` to generate a new file)
