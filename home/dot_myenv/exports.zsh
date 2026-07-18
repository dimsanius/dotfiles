# --- PATH ---
case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) export PATH="$HOME/.local/bin:$PATH" ;;
esac

# --- Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"

# --- fzf ---
export FZF_BASE="/usr/bin/fzf"
export FZF_DEFAULT_COMMAND="fdfind -u --exclude .git --exclude .venv --exclude .env --exclude '*.pyc'"
export DISABLE_FZF_AUTO_COMPLETION=true
export DISABLE_FZF_KEY_BINDINGS=true

# --- zoxide ---
export ZOXIDE_CMD_OVERRIDE=cd

# --- OMZ autoupdate ---
export ZSH_CUSTOM_AUTOUPDATE_QUIET=1
export ZSH_CUSTOM_AUTOUPDATE_NUM_WORKERS=8