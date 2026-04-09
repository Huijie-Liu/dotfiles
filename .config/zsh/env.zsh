# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

typeset -U path PATH
path=(
    "$HOME/.local/bin"
    $path
)

export EDITOR=nvim
export VISUAL=nvim

export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
