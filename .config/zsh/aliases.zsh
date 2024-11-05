# 文件管理别名
alias ls="eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias l="ls -la"
alias ll="ls -l"
alias la="ls -a"
alias d='dirs -v'
alias ..="cd .."
alias ...="cd ../.."

# 历史记录别名
alias h="history -10"
alias hc="history -c"
alias hg="history | grep "

# 文件操作别名
alias md="mkdir -p"
alias rd="rmdir"

# Tmux 控制别名
alias ta="tmux attach"
alias tl="tmux list-session"
alias ts="tmux new-session"

# 终端控制别名
alias c="clear"
alias x="exit"
alias r="source ~/.zshrc"
alias e="nvim ~/.zshrc"
alias f="find . -name"
alias dud="du -h -d 1"
alias duds="du -h -d 1 | sort -h"

# 自定义别名
alias nvs="nvidia-smi"
alias lg="lazygit"
alias clash="bash ~/.app/clash-for-linux/start.sh"
alias -g G='| grep'