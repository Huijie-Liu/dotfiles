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

# 创建配置目录
create_directory() {
  local dir=$1
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir" && success "创建目录 $dir"
  else
    success "目录 $dir 已存在，跳过..."
  fi
}

create_directory "$HOME/.config"
create_directory "$HOME/.config/fish"
create_directory "$HOME/.config/yabai"
create_directory "$HOME/.config/skhd"
create_directory "$HOME/.config/sketchybar"
create_directory "$HOME/.config/nvim"

# 创建配置文件软链接
DOTFILES_DIR="$HOME/.dotfiles"
create_symlink "$DOTFILES_DIR/.zshrc_macos" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.config/fish/config.fish" "$HOME/.config/fish/config.fish"
create_symlink "$DOTFILES_DIR/.config/alacritty" "$HOME/.config/alacritty"
create_symlink "$DOTFILES_DIR/.config/starship/starship-bracketed.toml" "$HOME/.config/starship.toml"
create_symlink "$DOTFILES_DIR/.config/yabai/yabairc" "$HOME/.config/yabai/yabairc"
create_symlink "$DOTFILES_DIR/.config/skhd/skhdrc" "$HOME/.config/skhd/skhdrc"
create_symlink "$DOTFILES_DIR/.config/sketchybar" "$HOME/.config/sketchybar"
create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
# 创建 scripts 目录软链接
create_directory "$HOME/.local/bin"

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
