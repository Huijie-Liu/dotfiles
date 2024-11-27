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

# 提示函数
prompt() {
  while true; do
    read -p "❓ $1 [y/n]: " yn
    case $yn in
      [Yy]*) return 0 ;;
      [Nn]*) return 1 ;;
      *) echo "请输入 y 或 n." ;;
    esac
  done
}

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

# 使用 Homebrew 安装函数
brew_install() {
  local package=$1
  local is_cask=$2

  if ! command_exists "$package"; then
    info "安装 $package..."
    if [ "$is_cask" = "true" ]; then
      brew install --cask "$package" || error_exit "安装 $package 失败"
    else
      brew install "$package" || error_exit "安装 $package 失败"
    fi
    success "$package 安装完成"
  else
    success "$package 已安装，跳过..."
  fi
}

# ======================================
# 开始脚本
# ======================================
echo -e "${GREEN}
===============================
✨ 开始安装和配置 macOS 环境
===============================
${NC}"

# 安装 Homebrew
if ! command_exists brew; then
  info "安装 Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || error_exit "安装 Homebrew 失败"
else
  success "Homebrew 已安装，跳过..."
fi

# 可选的 GUI 应用安装
GUI_APPS=("iterm2" "alacritty" "bartender" "bettertouchtool" "raycast" "1password" "typora")

for app in "${GUI_APPS[@]}"; do
  if prompt "是否安装 $app?"; then
    brew_install "$app" "true"
  fi
done

# 安装命令行工具
CLI_TOOLS=("zsh" "fish" "starship" "git" "fzf" "fd" "bat" "eza" "delta" "zoxide" "lazygit" "tldr" "thefuck")

for tool in "${CLI_TOOLS[@]}"; do
  brew_install "$tool" "false"
done

# 配置 Zsh
if prompt "是否配置 Zsh?"; then
  info "配置 Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || error_exit "安装 Oh My Zsh 失败"
  git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# 配置 Fish
if prompt "是否配置 Fish?"; then
  info "配置 Fish..."
  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
  fisher install IlanCosman/tide@v5
  fisher install jorgebucaran/fzf.fish
  fisher install jorgebucaran/autopair.fish
  fisher install jhillyerd/plugin-git
fi

# 创建基础配置目录
create_directory "$HOME/.config"
create_directory "$HOME/.local/bin"

# 创建配置文件软链接
DOTFILES_DIR="$HOME/.dotfiles"

# 处理 .config 目录下的第一层内容
if [ -d "$DOTFILES_DIR/.config" ]; then
    for item in "$DOTFILES_DIR/.config/"*; do
        if [ -e "$item" ]; then
            item_name=$(basename "$item")
            create_symlink "$item" "$HOME/.config/$item_name"
        fi
    done
fi

# 创建根目录下的配置文件软链接
create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.condarc" "$HOME/.condarc"

# 创建 scripts 目录下的脚本软链接
for script in "$DOTFILES_DIR/.scripts/"*; do
    if [ -f "$script" ]; then
        script_name=$(basename "$script")
        create_symlink "$script" "$HOME/.local/bin/$script_name"
    fi
done

echo -e "${GREEN}
🎉 所有工具安装和配置完成！
===============================
🚀 环境已成功配置，享受你的开发之旅吧！
===============================
${NC}"
