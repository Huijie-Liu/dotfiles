# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# PATH 配置
typeset -U PATH
path=(
    $HOME/.local/bin
    $path
)

# 编辑器设置
export EDITOR=nvim
export VISUAL=nvim

# Homebrew 镜像设置
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"

# 目录相关选项
setopt AUTO_CD              # 输入目录名直接切换
setopt AUTO_PUSHD          # 自动将目录添加到堆栈
setopt PUSHD_IGNORE_DUPS   # 避免重复的目录
setopt PUSHD_SILENT        # 不显示 pushd/popd 消息

# 历史记录配置
HISTFILE="$HOME/.histfile"
HISTSIZE=50000
SAVEHIST=$HISTSIZE
setopt inc_append_history        # 自动追加历史记录
setopt share_history            # 多个终端共享历史
setopt hist_expire_dups_first   # 删除重复的历史记录
setopt hist_ignore_dups         # 忽略连续重复的命令
setopt hist_verify              # 编辑历史命令前的确认
setopt hist_ignore_space        # 忽略以空格开头的命令