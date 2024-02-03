# dimsanius dotfiles

Installs environment (e.g. dotfiles, packages, fonts etc.) for the system.

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

- Ensure to put updated files and/or dotfiles within `~/.dotfiles/files`
- Navigate to the repo: `cd ~/dotfiles`
- Update symlinks:

```shell
stow -t ~ files -R
```

- Check updated symlinks
- If no errors - push changes to remote