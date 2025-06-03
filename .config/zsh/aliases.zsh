# 文件管理
# alias ls='eza'
# alias l='eza -A -1 --icons=always'
# alias la='eza -Al --git --icons=always'
# alias ll='eza -A --icons=always'
# alias lt='eza -T -L 2 --icons=always'
alias ls=lsd
alias l='lsd -l'
alias ll='lsd -lh'
alias la='lsd -A'
alias lla='lsd -lA'
alias llg='lsd -lAg'
alias lt='lsd --tree --depth 2'
alias lta='lsd --tree --depth 2 -a'

# 目录导航
alias ..='cd ..'
alias ...='cd ../..'

# 文件操作
alias md='mkdir -p'
alias rd='rmdir'

# Tmux 控制
alias ta='tmux attach'
alias tl='tmux list-session'
alias ts='tmux new-session'

# Zellij 控制
alias zj='zellij'
alias za='zellij attach'
alias zl='zellij list-sessions'
alias zs='zellij --session'
alias zk='zellij kill-session'
alias zka='zellij kill-all-sessions'
alias zjl='zellij --layout'

# 终端控制 
alias c='clear'
alias r='source ~/.zshrc'
alias e='nvim ~/.zshrc'
alias v='nvim'

# Nix 命令 
local NIX_CMD=~/.nix-portable/nix-portable\ nix
alias nix="$NIX_CMD"
ns() { $NIX_CMD shell "nixpkgs#$1" }
nr() { $NIX_CMD run "nixpkgs#$1" }
alias nf="$NIX_CMD flake"

# 自定义命令 
alias nvs='nvidia-smi'
alias lg='lazygit'
alias ff='fastfetch'
alias mm='micromamba'
