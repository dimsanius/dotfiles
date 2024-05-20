# fzf styling
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:-1,bg:-1,hl:#ffcb6b
 --color=fg+:,bg+:#5f5f5f,hl+:#6ffd00
 --color=info:#c3e88d,prompt:#6ffd00,pointer:#6ffd00
 --color=marker:#c3e88d,spinner:#c3e88d,header:#c3e88d'

# Use fdfind for fzf
export FZF_DEFAULT_COMMAND="fdfind -u --type f"

# ---- system ----

# Preview 'systemctl' unit status
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# Show environment variable contents
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

# Preview file/folder contents
zstyle ':fzf-tab:complete:(cd|rm|cp|batcat|cat|vim):*' fzf-preview 'if [[ -d $realpath ]]; then exa -1 --color=always --icons --group-directories-first $realpath; else batcat --color=always --plain $realpath; fi'

# Force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# Set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ---- git ----

# Disable sort in some cases for git
zstyle ':completion:*:git-(checkout|log|diff|show):*' sort false

# Preview 'git log'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'

# Preview 'git help'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | batcat -plman --color=always'

# Preview for 'git show'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'

# Preview for 'git checkout'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'