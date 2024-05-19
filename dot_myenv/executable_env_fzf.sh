# fzf styling
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:-1,bg:-1,hl:#ffcb6b
 --color=fg+:,bg+:#5f5f5f,hl+:#6ffd00
 --color=info:#c3e88d,prompt:#6ffd00,pointer:#6ffd00
 --color=marker:#c3e88d,spinner:#c3e88d,header:#c3e88d'

# Use fdfind to find all the files
export FZF_DEFAULT_COMMAND="fdfind -u --type f"

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'if [[ -d $realpath ]]; then exa -1 --color=always --icons --group-directories-first $realpath; else batcat --color=always --plain $realpath; fi'
# preview directory's content with exa when completing rm, preview files
zstyle ':fzf-tab:complete:rm:*' fzf-preview 'if [[ -d $realpath ]]; then exa -1 --color=always --icons --group-directories-first $realpath; else batcat --color=always --plain $realpath; fi'
# preview directory's content with exa when completing cp, preview files
zstyle ':fzf-tab:complete:cp:*' fzf-preview 'if [[ -d $realpath ]]; then exa -1 --color=always --icons --group-directories-first $realpath; else batcat --color=always --plain $realpath; fi'
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}