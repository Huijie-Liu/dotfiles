function fish_greeting
end

# 历史记录配置
set -x HISTFILE "$HOME/.histfile"
set -x HISTSIZE 50000
set -x SAVEHIST $HISTSIZE
set -g fish_history inc_append_history
set -g fish_history share_history
set -g fish_history hist_expire_dups_first
set -g fish_history hist_ignore_dups
set -g fish_history hist_verify
set -g fish_history hist_ignore_space

# PATH 配置
set -U fish_user_paths $HOME/.local/bin $HOME/.local/usr/bin $HOME/.cargo/bin $fish_user_paths

# CUDA 配置
set -x CUDA_VERSION "12.4"
set -x CUDA_HOME "/usr/local/cuda-$CUDA_VERSION"
set -x PATH "$CUDA_HOME/bin:$PATH"

# PKG_CONFIG_PATH
set -U PKG_CONFIG_PATH $HOME/.local/lib/pkgconfig $PKG_CONFIG_PATH
set -x PKG_CONFIG_PATH (string join : $PKG_CONFIG_PATH)

# LD_LIBRARY_PATH
set -U LD_LIBRARY_PATH /usr/local/cuda-$CUDA_VERSION/lib64 $HOME/.local/lib $HOME/.local/usr/lib $HOME/.local/usr/lib/x86_64-linux-gnu $LD_LIBRARY_PATH
set -x LD_LIBRARY_PATH (string join : $LD_LIBRARY_PATH)

# 其他环境变量
set -x HF_ENDPOINT "https://hf-mirror.com"
set -x TMPDIR "$HOME/.tmp"
if not test -d $TMPDIR
    mkdir -p $TMPDIR
end

# 目录相关选项
set -g fish_auto_cd
set -g fish_pushd_auto
set -g fish_pushd_ignore_dups
set -g fish_pushd_silent