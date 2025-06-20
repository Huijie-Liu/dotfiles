# 文件管理
alias ls=lsd
alias l='lsd -l'
alias ll='lsd -lA'
alias la='lsd -A'
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

# 自定义命令 
alias nvs='nvidia-smi'
alias lg='lazygit'
alias ff='fastfetch'
alias mm='micromamba'
alias one='onefetch'
alias nix='export IN_NIX_USER_CHROOT=1; export NP_RUNTIME=bwrap; ~/.nix-portable/nix-portable nix develop ~/.dotfiles'
