# Basic
alias c=clear
alias v=nvim

# Git
alias g=git
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gd="git diff"
alias gr="git restore"
alias grs="git restore --staged"
alias gb="git branch"
alias gam="git commit --amend"

# File system
alias ls=lsd
alias l='lsd -l'
alias ll='lsd -lA'
alias la='lsd -A'
alias lt='lsd --tree --depth 2'
alias lta='lsd --tree --depth 2 -a'
alias cd=z
alias md="mkdir -p"
alias rd=rmdir

# Tmux
alias ta="tmux attach"
alias tl="tmux list-session"
alias ts="tmux new-session"

# Zellij
alias zj=zellij
alias za="zellij attach"
alias zl="zellij list-sessions"
alias zs="zellij --session"
alias zk="zellij kill-session"
alias zka="zellij kill-all-sessions"
alias zjl="zellij --layout"

# Homebrew
alias b=brew
alias bi="brew install"
alias bu="brew uninstall"
alias bc="brew cleanup --prune=all"
alias bs="brew search"
alias bU="brew update && brew upgrade && brew cleanup --prune=all"
alias ba="brew abv"
alias bd="brew desc"
alias bD="brew doctor"
alias bo="brew outdated"
alias bl="brew list"
alias bI="brew info"

# Tool
alias lg=lazygit
alias ff=fastfetch
alias one=onefetch
alias mm=micromamba
alias 7z=7zz

# Global aliases
alias -g G='| grep'
alias -g L='| less'