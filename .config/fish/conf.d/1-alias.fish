# 终端操作
alias c="clear"
alias x="exit"
alias e="nvim ~/.config/fish/config.fish"
alias r="source ~/.config/fish/config.fish"
alias v="nvim"

# 文件管理
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias la="eza --color=always --long --git --icons=always"
alias laa="eza --color=always --long --git --icons=always -la"
alias l="ls -la"
alias lt="ls --tree --level 2"
alias cd="z"
alias md="mkdir -p"
alias rd="rmdir"

# 历史记录
alias h="history -10" # 最近10条历史记录
alias hg="history | grep " # 搜索历史记录

# Tmux
alias ta="tmux attach"
alias tl="tmux list-session"
alias ts="tmux new-session"

# zellij
alias zj="zellij"
alias za="zellij attach"
alias zl="zellij list-sessions"
alias zs="zellij --session"
alias zk="zellij kill-session"
alias zka="zellij kill-all-sessions"

# 系统工具
alias proxy="export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890"

# 开发工具
alias python="python3"
alias lg="lazygit"

# 其他工具
alias dw="download_wallpaper"
alias ff="fastfetch"
