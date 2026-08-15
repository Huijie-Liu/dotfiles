# PATH
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.pixi/bin

# CUDA
set -x CUDA_VERSION "11.8"
set -x CUDA_HOME "/usr/local/cuda-$CUDA_VERSION"
fish_add_path $CUDA_HOME/bin

# PKG_CONFIG_PATH
set -x PKG_CONFIG_PATH $HOME/.local/lib/pkgconfig $PKG_CONFIG_PATH

# LD_LIBRARY_PATH
set -x LD_LIBRARY_PATH /usr/local/cuda-$CUDA_VERSION/lib64 $HOME/.local/lib $LD_LIBRARY_PATH

# EDITOR
set -x EDITOR nvim
set -x VISUAL nvim

# NIX
fish_add_path --prepend "$HOME/.nix-profile/bin"
fish_add_path --prepend "/nix/var/nix/profiles/default/bin"
