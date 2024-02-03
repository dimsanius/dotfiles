# dimsanius dotfiles

Installs environment (e.g. dotfiles, packages, fonts etc.) for the system.

## Dependecies

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

- Ensure to put updated files and/or dotfiles within `~/.dotfiles/files`
- Navigate to the repo: `cd ~/dotfiles`
- Update symlinks:

```shell
stow -t ~ files -R
```

- Check updated symlinks
- If no errors - push changes to remote

## TODO

- Try to make install fully unattended
- Execute the script with sudo to avoid typing password many times
- Regex for git user and email
- SSH key check - create prompt to continue via HTTPS
- Silence GitHub key acquisition (hmm, maybe?)
- Try to split setup for headlesss distros
- Introduce --update command to update symlinks