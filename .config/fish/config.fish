function fish_greeting
end

# PATH 配置
set -x fish_user_paths $HOME/.local/bin $HOME/.local/usr/bin $HOME/.cargo/bin

# CUDA 配置
set -x CUDA_VERSION "12.4"
set -x CUDA_HOME "/usr/local/cuda-$CUDA_VERSION"
set -x fish_user_paths $CUDA_HOME/bin:$PATH $fish_user_paths

# PKG_CONFIG_PATH
set -x PKG_CONFIG_PATH $HOME/.local/lib/pkgconfig

# LD_LIBRARY_PATH
set -x LD_LIBRARY_PATH $HOME/.local/lib $HOME/.local/usr/lib $HOME/.local/usr/lib/x86_64-linux-gnu /usr/local/cuda-$CUDA_VERSION/lib64

# 其他环境变量
set -x HF_ENDPOINT "https://hf-mirror.com"
set -x TMPDIR "$HOME/.tmp"
if not test -d $TMPDIR
    mkdir -p $TMPDIR
end

set -Ux EDITOR nvim
set -Ux VISUAL nvim

set -Ux HISTFILE ~/.histfile

set -x http_proxy "http://127.0.0.1:17890"
set -x https_proxy "http://127.0.0.1:17890"
