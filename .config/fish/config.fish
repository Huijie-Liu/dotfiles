# ===========================
# 1. 环境变量配置
# ===========================
# Homebrew
eval (/opt/homebrew/bin/brew shellenv)

# PATH 配置
set -gx PATH /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin $PATH
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH $HOME/.local/share/nvim/mason/bin $PATH
set -gx PATH $HOME/.local/share/bob/nvim-bin $PATH

# ===========================
# 2. Shell 主题和界面配置
# ===========================
# 移除欢迎语
set fish_greeting

# Starship 主题
starship init fish | source

# ===========================
# 3. FZF 配置
# ===========================
# 基础配置
fzf --fish | source
fzf_configure_bindings --directory=\ct --git_status=\cgs --git_log=\cgl --history=\cr

# 预览配置
set fzf_preview_dir_cmd eza --all --color=always
set fzf_fd_opts --hidden --max-depth 5

# FZF 选项
export FZF_DEFAULT_OPTS="--layout=reverse"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# ===========================
# 4. 常用别名
# ===========================
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
alias proxy="export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890 && echo 代理成功"

# 开发工具
alias python="python3"
alias lg="lazygit"

# 其他工具
alias ydl="youtube-dl"
alias dw="download_wallpaper"
alias ff="fastfetch"

# ===========================
# 5. 自定义函数
# ===========================
function mkcd
    mkdir -p $argv; and cd $argv
end

# ===========================
# 6. Zoxide（更好的cd）
# ===========================
zoxide init fish | source

# ===========================
# 7. Conda 配置
# ===========================
# >>> conda initialize >>>
if test -f /opt/miniconda3/bin/conda
    status is-interactive && eval /opt/miniconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
        . "/opt/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /opt/miniconda3/bin $PATH
    end
end
# <<< conda initialize <<<
