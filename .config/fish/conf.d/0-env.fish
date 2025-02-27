# PATH 配置
set -x PATH $HOME/.local/bin $PATH

# PKG_CONFIG_PATH
set -x PKG_CONFIG_PATH $HOME/.local/lib/pkgconfig $PKG_CONFIG_PATH

# LD_LIBRARY_PATH
set -x LD_LIBRARY_PATH $HOME/.local/lib $LD_LIBRARY_PATH

# 其他环境变量
set -x HF_ENDPOINT "https://hf-mirror.com"
set -x TMPDIR "$HOME/.tmp"
if not test -d $TMPDIR
    mkdir -p $TMPDIR
end

# CUDA
#set -x PATH /usr/local/cuda-11.8/bin $PATH
#set -x LD_LIBRARY_PATH /usr/local/cuda-11.8/lib64 $LD_LIBRARY_PATH
