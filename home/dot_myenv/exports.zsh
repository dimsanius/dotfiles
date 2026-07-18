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
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS }\
--color=fg:-1,bg:-1,hl:#c3e88d \
--color=fg+:,bg+:#575757,hl+:#c3e88d \
--color=info:#c3e88d,prompt:#c3e88d,pointer:#c3e88d \
--color=marker:#c3e88d,spinner:#c3e88d,header:#c3e88d"

# --- zoxide ---
export ZOXIDE_CMD_OVERRIDE=cd

# --- OMZ autoupdate ---
export ZSH_CUSTOM_AUTOUPDATE_QUIET=1
export ZSH_CUSTOM_AUTOUPDATE_NUM_WORKERS=8