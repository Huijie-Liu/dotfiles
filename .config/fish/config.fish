# Homebrew
eval (/opt/homebrew/bin/brew shellenv)

# aliases
alias proxy="export all_proxy=http://127.0.0.1:7890 && echo 代理成功"
alias ydl="youtube-dl"
alias dw="download_wallpaper"
alias ssh_vcg="ssh -i ~/.ssh/id_vcg lhj@211.71.15.42" # 连接实验室服务器
alias c="clear"
alias x="exit"
alias python="python3"


# bind clear-screen shortcut from \cl to \el
bind --preset \el clear-screen


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/jay/anaconda3/bin/conda
    eval /Users/jay/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<


# -----bobthefish-----
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_color_scheme solarized

# left side
set -g theme_display_user ssh
set -g default_user jay

# right side
set -g theme_display_date yes
set -g theme_date_format -u +%h:%M:%S
set -g theme_display_cmd_duration no


# -----fzf-----
# Set up fzf key bindings
fzf --fish | source

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"


# ---- Eza (better ls) -----
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias l="ls -la"


# -----TheFuck tool-----
thefuck --alias | source
thefuck --alias fk | source


# ---- Zoxide (better cd) ----
zoxide init fish | source
