# 终端操作
alias c="clear"
alias x="exit"
alias e="nvim ~/.config/fish/config.fish"
alias r="source ~/.config/fish/config.fish"

# 文件管理
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias l="ls -la"
alias cd="z"
alias md="mkdir -p"
alias rd="rmdir"

# 历史记录
alias h="history -10" # 最近10条历史记录
alias hg="history | grep " # 搜索历史记录

# Tmux 控制
alias ta="tmux attach"
alias tl="tmux list-session"
alias ts="tmux new-session"

# 系统工具
alias proxy="set -x https_proxy http://127.0.0.1:7890; set -x http_proxy http://127.0.0.1:7890; set -x all_proxy socks5://127.0.0.1:7890; echo 代理成功"

# 开发工具
alias python="python3"
alias lg="lazygit"

# 其他工具
alias ydl="youtube-dl"
alias dw="download_wallpaper"
alias ff="fastfetch"
