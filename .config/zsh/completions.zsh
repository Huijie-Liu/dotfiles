# 基础设置
setopt AUTO_LIST           # 自动列出可能的补全
setopt MENU_COMPLETE       # 第一次 Tab 就显示完整菜单
setopt ALWAYS_TO_END       # 补全后将光标移到末尾
unsetopt BASH_AUTO_LIST    # 禁用 Bash 风格的双 Tab 补全

# 补全系统初始化
if [ ! -f ~/.zcompdump ] || [ $(date +'%j') != $(stat -c '%y' ~/.zcompdump 2>/dev/null | date +'%j' -f -) ]; then
    autoload -Uz compinit && compinit
else
    autoload -Uz compinit && compinit -C
fi

# 补全设置
# 基础补全配置
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes

# 智能匹配和纠错
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# 路径补全优化
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# 进程和命令补全
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# 界面美化
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'