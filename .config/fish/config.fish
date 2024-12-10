function fish_greeting
end

# CUDA 配置
set -x CUDA_VERSION "12.4"
set -x CUDA_HOME "/usr/local/cuda-$CUDA_VERSION"
set -x PATH $CUDA_HOME/bin $PATH

# LD_LIBRARY_PATH
set -x LD_LIBRARY_PATH /usr/local/cuda-$CUDA_VERSION/lib64 $LD_LIBRARY_PATH

# 其他环境变量
set -x HF_ENDPOINT "https://hf-mirror.com"
set -x TMPDIR "$HOME/.tmp"
if not test -d $TMPDIR
    mkdir -p $TMPDIR
end

set -Ux EDITOR nvim
set -Ux VISUAL nvim

set -x http_proxy "http://127.0.0.1:17890"
set -x https_proxy "http://127.0.0.1:17890"
