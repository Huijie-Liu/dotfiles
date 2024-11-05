# PATH 配置
typeset -U PATH
path=(
    $HOME/.local/bin
    $HOME/.local/usr/bin
    $HOME/.cargo/bin
    $path
)

# CUDA 配置
export CUDA_VERSION="11.8"
export CUDA_HOME="/usr/local/cuda-$CUDA_VERSION"
export PATH="$CUDA_HOME/bin:$PATH"

# PKG_CONFIG_PATH
typeset -U PKG_CONFIG_PATH
pkg_config_path=(
    $HOME/.local/lib/pkgconfig
    $PKG_CONFIG_PATH
)
export PKG_CONFIG_PATH=${(j/:/)pkg_config_path}

# LD_LIBRARY_PATH
typeset -U LD_LIBRARY_PATH
library_path=(
    /usr/local/cuda-$CUDA_VERSION/lib64
    $HOME/.local/lib
    $HOME/.local/usr/lib
    $HOME/.local/usr/lib/x86_64-linux-gnu
    $LD_LIBRARY_PATH
)
export LD_LIBRARY_PATH=${(j/:/)library_path}

# 其他环境变量
export HF_ENDPOINT="https://hf-mirror.com"
export TMPDIR="$HOME/.tmp"
[[ ! -d $TMPDIR ]] && mkdir -p $TMPDIR

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