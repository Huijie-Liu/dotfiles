#!/bin/bash

# 定义颜色
RED='\033[31m'
GREEN='\033[32m'
BLUE='\033[34m'
NC='\033[0m' # No Color

# 输出函数
info() {
  echo -e "${BLUE}[ℹ️  信息]${NC} $1"
}

success() {
  echo -e "${GREEN}[✅ 成功]${NC} $1"
}

error_exit() {
  echo -e "${RED}[❌ 错误]${NC} $1"
  exit 1
}

# 检查命令是否存在
command_exists() {
  command -v "$1" &>/dev/null
}

# 手动将 Miniconda 路径添加到 PATH
export PATH="$HOME/.miniconda/bin:$PATH"

# 创建软链接函数
create_symlink() {
  local target=$1
  local link_name=$2

  if [ ! -e "$link_name" ]; then
    ln -sf "$target" "$link_name"
    success "创建软链接 $link_name -> $target"
  else
    success "$link_name 已存在，跳过..."
  fi
}

# 克隆 Git 仓库函数
clone_repo() {
  local repo_url=$1
  local dest_dir=$2
  local repo_name=$3

  if [ ! -d "$dest_dir" ]; then
    info "克隆 $repo_name 仓库..."
    git clone "$repo_url" "$dest_dir" || error_exit "克隆 $repo_name 失败"
  else
    success "$repo_name 已存在，跳过..."
  fi
}

# 创建目录函数
create_directory() {
  local dir=$1
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir" && success "创建目录 $dir"
  else
    success "目录 $dir 已存在，跳过..."
  fi
}

# ======================================
# 开始脚本
# ======================================
echo -e "${GREEN}
===============================
✨ 开始安装和配置环境
===============================
${NC}"

# 创建软链接
create_symlink "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"

# 创建 ~/.config 目录
create_directory "$HOME/.config"

# ======================================
# 安装或更新 Miniconda
# ======================================
if ! command_exists conda; then
  info "下载 Miniconda..."
  wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh || error_exit "下载 Miniconda 失败"

  info "安装 Miniconda..."
  bash miniconda.sh -b -p "$HOME/.miniconda" || error_exit "安装 Miniconda 失败"
  rm miniconda.sh

  info "初始化 conda..."
  source "$HOME/.miniconda/etc/profile.d/conda.sh"
  conda init || error_exit "初始化 conda 失败"
  source "$HOME/.zshrc"
else
  success "Miniconda 已安装，跳过..."
  source "$HOME/.miniconda/etc/profile.d/conda.sh"
fi

# ======================================
# 安装 lazygit
# ======================================
if ! command_exists lazygit; then
  info "使用 conda 安装 lazygit..."
  conda install -c conda-forge lazygit -y || error_exit "安装 lazygit 失败"
else
  success "lazygit 已安装，跳过..."
fi

# ======================================
# 安装 Neovim
# ======================================
if ! command_exists nvim; then
  info "下载 Neovim..."
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz || error_exit "下载 Neovim 失败"

  info "解压 Neovim..."
  tar -xzf nvim-linux64.tar.gz || error_exit "解压 Neovim 失败"
  rm nvim-linux64.tar.gz

  info "安装 Neovim 到 ~/.local/..."
  rsync -a nvim-linux64/ "$HOME/.local/" || error_exit "安装 Neovim 失败"
  rm -rf nvim-linux64

  # 添加 Neovim 到 PATH
  if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >>"$HOME/.bashrc"
    source "$HOME/.bashrc"
  fi
else
  success "Neovim 已安装，跳过..."
fi

# ======================================
# 安装 fzf
# ======================================
if ! command_exists fzf; then
  clone_repo "https://github.com/junegunn/fzf.git" "$HOME/.fzf" "fzf"
  "$HOME/.fzf/install" --all || error_exit "安装 fzf 失败"
else
  success "fzf 已安装，跳过..."
fi

# ======================================
# 安装 Rust 工具链
# ======================================
if ! command_exists rustc; then
  info "安装 Rust 工具链..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || error_exit "安装 Rust 失败"
  source "$HOME/.cargo/env"
else
  success "Rust 已安装，跳过..."
fi

# ======================================
# 使用 cargo 安装工具
# ======================================
cargo_packages=("zoxide" "eza" "starship" "bat" "yazi-fm" "yzai-cli")

for pkg in "${cargo_packages[@]}"; do
  if ! command_exists "$pkg"; then
    info "使用 cargo 安装 $pkg..."
    cargo install "$pkg" --locked || error_exit "安装 $pkg 失败"
  else
    success "$pkg 已安装，跳过..."
  fi
done

# ======================================
# 创建 .config 目录下所有文件的软链接
# ======================================
DOTFILES_DIR="$HOME/.dotfiles"
if [ -d "$DOTFILES_DIR/.config" ]; then
  for config_item in "$DOTFILES_DIR/.config/"*; do
    if [ -e "$config_item" ]; then
      item_name=$(basename "$config_item")
      create_symlink "$config_item" "$HOME/.config/$item_name"
    fi
  done
fi

# 创建根目录下的配置文件软链接
create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/.condarc" "$HOME/.condarc"

create_directory "$HOME/.local/bin"

for script in "$DOTFILES_DIR/.scripts/"*; do
  if [ -f "$script" ]; then
    script_name=$(basename "$script")
    create_symlink "$script" "$HOME/.local/bin/$script_name"
  fi
done

# ======================================
# 安装 tmux plugin manager (tpm)
# ======================================
clone_repo "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm" "tmux plugin manager (tpm)"

echo -e "${GREEN}
🎉 所有工具安装和配置完成！
===============================
🚀 环境已成功配置，享受你的开发之旅吧！
===============================
${NC}"
