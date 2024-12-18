# Homebrew
eval (/opt/homebrew/bin/brew shellenv)

# PATH 配置
set -x fish_user_paths $HOME/.local/bin
set -x fish_user_paths $HOME/.cargo/bin

set -x EDITOR nvim
