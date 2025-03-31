# Homebrew
eval (/opt/homebrew/bin/brew shellenv)

# PATH 配置
set -x PATH $HOME/.local/bin $PATH

set -x EDITOR nvim
set -x VISUAL nvim

set -x HOMEBREW_BREW_GIT_REMOTE "https://mirrors.ustc.edu.cn/brew.git"
set -x HOMEBREW_CORE_GIT_REMOTE "https://mirrors.ustc.edu.cn/homebrew-core.git"
set -x HOMEBREW_BOTTLE_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"
set -x HOMEBREW_API_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles/api"
