# fzf styling
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS }\
--color=fg:-1,bg:-1,hl:#c3e88d \
--color=fg+:,bg+:#575757,hl+:#c3e88d \
--color=info:#c3e88d,prompt:#c3e88d,pointer:#c3e88d \
--color=marker:#c3e88d,spinner:#c3e88d,header:#c3e88d"

# ---- system ----

# Make non-dir commands use folder->file grouping
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*:descriptions' format '%d'
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' show-group none

# Preview 'systemctl' unit status
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status "$word" | fold -s -w ${FZF_PREVIEW_COLUMNS:-80}'

# Show environment variable contents
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word} | fold -s -w ${FZF_PREVIEW_COLUMNS:-80}'

# Preview file/folder contents
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always --icons --group-directories-first $realpath'
zstyle ':fzf-tab:complete:(rm|cp|batcat|cat|vim|nano):*' fzf-preview 'if [[ -d $realpath ]]; then exa -1 --color=always --icons --group-directories-first $realpath; else batcat --color=always --plain $realpath; fi'

# Force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# Set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ---- git ----

# Disable sort in some cases for git
zstyle ':completion:*:git-(checkout|log|diff|show|reset|rebase):*' sort false

# Preview 'git help'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | fmt -w ${FZF_PREVIEW_COLUMNS:-80} | batcat -plman --color=always'

# Preview for 'git show', 'git checkout' and 'git log'
zstyle ':fzf-tab:complete:git-(log|show|checkout):*' fzf-preview 'git show --color=always $word | delta'

# Preview for 'git diff'
zstyle ':fzf-tab:complete:git-diff:*' fzf-preview 'git diff --color=always $word | delta'


# --- fzf-tab styling ---
zstyle ':fzf-tab:*' fzf-flags ${(z)FZF_DEFAULT_OPTS}