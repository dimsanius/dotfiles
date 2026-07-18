# completion ordering
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*:descriptions' format '[%d]'

# fzf-tab
zstyle ':fzf-tab:*' show-group none
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

# previews
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview \
    'SYSTEMD_COLORS=1 systemctl status "$word" | fold -s -w ${FZF_PREVIEW_COLUMNS:-80}'

zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
    fzf-preview 'echo ${(P)word} | fold -s -w ${FZF_PREVIEW_COLUMNS:-80}'

zstyle ':fzf-tab:complete:cd:*' \
    fzf-preview 'exa -1 --color=always --icons --group-directories-first $realpath'

zstyle ':fzf-tab:complete:(rm|cp|batcat|cat|vim|nano|code|subl):*' \
    fzf-preview 'if [[ -d $realpath ]]; then exa -1 --color=always --icons --group-directories-first $realpath; else batcat --color=always --plain $realpath; fi'

# completion menu
zstyle ':completion:*' menu no

# colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# git completion
zstyle ':completion:*:git-(checkout|log|diff|show|reset|rebase):*' sort false

zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
    'git help $word | fmt -w ${FZF_PREVIEW_COLUMNS:-80} | batcat -plman --color=always'

zstyle ':fzf-tab:complete:git-(log|show|checkout):*' fzf-preview \
    'git show --color=always $word | delta'

zstyle ':fzf-tab:complete:git-diff:*' fzf-preview \
    'git diff --color=always $word | delta'