# PATH 配置
set -x PATH $HOME/.local/bin $HOME/.local/usr/bin $HOME/.cargo/bin $PATH

# PKG_CONFIG_PATH
set -x PKG_CONFIG_PATH $HOME/.local/lib/pkgconfig
#
# LD_LIBRARY_PATH
set -x LD_LIBRARY_PATH $HOME/.local/lib $HOME/.local/usr/lib $HOME/.local/usr/lib/x86_64-linux-gnu
