# fzf styling
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:-1,bg:-1,hl:#ffcb6b
 --color=fg+:,bg+:#5f5f5f,hl+:#6ffd00
 --color=info:#c3e88d,prompt:#6ffd00,pointer:#6ffd00
 --color=marker:#c3e88d,spinner:#c3e88d,header:#c3e88d'


# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always --icons --group-directories-first $realpath'
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no