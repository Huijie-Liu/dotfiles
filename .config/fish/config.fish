# Homebrew
eval (/opt/homebrew/bin/brew shellenv)


# ----- greetings -----
set fish_greeting # remove the greeting


# ----- starship -----
starship init fish | source


# ----- fzf -----
fzf --fish | source
fzf_configure_bindings --directory=\ct --git_status=\cgs --git_log=\cgl --history=\cr
set fzf_preview_dir_cmd eza --all --color=always
set fzf_fd_opts --hidden --max-depth 5
export FZF_DEFAULT_OPTS="--layout=reverse"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"


# ----- Eza (better ls) -----
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias l="ls -la"


# ----- Zoxide (better cd) -----
zoxide init fish | source
alias cd="z"


# ----- aliases -----
# terminal
alias c="clear"
alias x="exit"
# history
alias h="history -10" # last 10 history commands
alias hc="history -c" # clear history
alias hg="history | grep " # +command
# system
alias proxy="export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890 && echo 代理成功"
# file
alias md="mkdir -p"
alias rd="rmdir"
# tmux
alias ta="tmux attach"
alias tl="tmux list-session"
alias ts="tmux new-session"
# git
alias g="git"
alias gc="git commit -m"
alias ga='git add'
alias gaa='git add --all'
alias gst='git status'
alias gss='git status --short'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
# customization
alias ydl="youtube-dl"
alias python="python3"
alias lg="lazygit"
alias dw="download_wallpaper"
alias ff="fastfetch"


# ----- Functions -----
function mkcd
    mkdir -p $argv; and cd $argv
end


# ----- PATH -----
export PATH="$HOME/.scripts:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
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
