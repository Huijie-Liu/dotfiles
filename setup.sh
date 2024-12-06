#!/bin/bash

# 配置颜色
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
CYAN='\033[36m'
NC='\033[0m'

# 清屏功能
clear_screen() { printf "\033c"; }

# 标题
show_title() {
  clear_screen
  echo -e "${CYAN}
===============================
✨ Dotfiles 安装助手
===============================
${NC}"
}

# 显示欢迎信息
show_welcome_message() {
  echo -e "${YELLOW}欢迎！本脚本将帮助您自动安装和配置开发环境。
请选择要安装的组件，脚本将一步步引导您完成安装过程。
${NC}"
}

# 配置交互菜单
components=(
  "Miniconda (包管理器)"
  "lazygit (Git 界面工具)"
  "Neovim (现代化文本编辑器)"
  "Rust 工具链 (编程语言环境)"
  "fzf (模糊搜索工具)"
  "tmux plugin manager (tpm)"
  "Cargo 工具 (多个包)"
)
selected=()

# 记录失败的工具
failed_components=()

# 显示交互菜单
display_menu() {
  echo -e "${GREEN}请选择要安装的组件 (输入序号，以空格分隔，回车确认)${NC}"
  for i in "${!components[@]}"; do
    echo -e "${CYAN}  $((i+1))) ${components[$i]}${NC}"
  done
}

# 获取用户选择
get_user_selection() {
  read -p "输入序号 (默认全部): " input
  if [ -z "$input" ]; then
    selected=("${components[@]}")
  else
    for idx in $input; do
      if [[ $idx -gt 0 && $idx -le ${#components[@]} ]]; then
        selected+=("${components[$((idx-1))]}")
      fi
    done
  fi
}

# 创建目录
create_directory() {
  local dir=$1
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir" && echo -e "${GREEN}[成功] 创建目录: $dir${NC}" || {
      echo -e "${RED}[失败] 创建目录失败: $dir${NC}"
      failed_components+=("目录: $dir")
    }
  else
    echo -e "${GREEN}[已存在] 目录: $dir${NC}"
  fi
}


# 全局数组存储错误信息
error_messages=()

install_component() {
  local name=$1          # 组件名称
  local install_cmd=$2   # 安装命令
  local check_cmd=$3     # 检查组件是否已安装的命令

  clear_screen
  show_title

  # 检查是否已安装
  echo -e "${BLUE}检测 $name 是否已安装...${NC}"
  if eval "$check_cmd"; then
    echo -e "${GREEN}[已安装] $name 已存在，跳过安装。${NC}"
  else
    echo -e "${BLUE}开始安装: $name${NC}"
    # 捕获安装过程中的错误
    local output
    output=$(eval "$install_cmd" 2>&1)
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}[成功] $name 安装完成${NC}"
    else
      echo -e "${RED}[失败] $name 安装失败，请检查网络或依赖。${NC}"
      failed_components+=("$name")
      error_messages+=("$name: $output")
    fi
  fi
  sleep 1
}

install_cargo_packages() {
  clear_screen
  show_title

  local cargo_packages=("zoxide" "fd-find" "eza" "starship" "bat" "yazi-fm" "yazi-cli")
  for pkg in "${cargo_packages[@]}"; do
    if ! command -v "$pkg" &>/dev/null; then
      echo -e "${BLUE}使用 cargo 安装 $pkg...${NC}"
      # 捕获安装过程中的错误
      local output
      output=$(cargo install "$pkg" --locked 2>&1)
      if [ $? -eq 0 ]; then
        echo -e "${GREEN}[成功] $pkg 安装完成${NC}"
      else
        echo -e "${RED}[失败] $pkg 安装失败${NC}"
        failed_components+=("$pkg")
        error_messages+=("$pkg: $output")
      fi
    else
      echo -e "${GREEN}[已安装] $pkg 已存在，跳过安装。${NC}"
    fi
  done
}

# 创建符号链接
create_symlink() {
  local target=$1
  local link_name=$2
  if [ -e "$link_name" ]; then
    echo -e "${YELLOW}[跳过] 符号链接已存在: $link_name -> $target${NC}"
  else
    ln -sf "$target" "$link_name" && echo -e "${GREEN}[成功] 创建符号链接: $link_name -> $target${NC}" || {
      echo -e "${RED}[失败] 创建符号链接失败: $link_name -> $target${NC}"
      failed_components+=("符号链接: $link_name -> $target")
    }
  fi
}

setup_dotfiles() {
  clear_screen
  show_title

  echo -e "${BLUE}开始配置符号链接和目录...${NC}"

  # 创建 ~/.config 目录并链接配置文件
  create_directory "$HOME/.config"
  DOTFILES_DIR="$HOME/.dotfiles"
  if [ -d "$DOTFILES_DIR/.config" ]; then
    for config_item in "$DOTFILES_DIR/.config/"*; do
      [ -e "$config_item" ] && create_symlink "$config_item" "$HOME/.config/$(basename "$config_item")"
    done
  fi

  # 链接 .tmux.conf 和 .condarc
  create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
  create_symlink "$DOTFILES_DIR/.condarc" "$HOME/.condarc"

  # 创建 ~/.local/bin 目录并链接脚本
  create_directory "$HOME/.local/bin"
  for script in "$DOTFILES_DIR/.scripts/"*; do
    [ -f "$script" ] && create_symlink "$script" "$HOME/.local/bin/$(basename "$script")"
  done
}

# 开始安装
start_installation() {
  for component in "${selected[@]}"; do
    case "$component" in
      "Miniconda (包管理器)")
        install_component "Miniconda" "
          wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh &&
          bash miniconda.sh -b -p \$HOME/.miniconda &&
          rm miniconda.sh &&
          source \$HOME/.miniconda/etc/profile.d/conda.sh &&
          conda init
        " "command -v conda"
        ;;
      "lazygit (Git 界面工具，依赖 conda)")
        if ! command -v conda &>/dev/null; then
          echo -e "${RED}[依赖缺失] lazygit 需要 conda，请先安装 Miniconda。${NC}"
          failed_components+=("lazygit (缺少 conda)")
          continue
        fi
        install_component "lazygit" "conda install -c conda-forge lazygit -y" "command -v lazygit"
        ;;
      "Neovim (现代化文本编辑器)")
        install_component "Neovim" "
          curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz &&
          tar -xzf nvim-linux64.tar.gz &&
          rsync -a nvim-linux64/ \$HOME/.local/ &&
          rm -rf nvim-linux64 nvim-linux64.tar.gz
        " "command -v nvim"
        ;;
      "Rust 工具链 (部分工具的依赖)")
        install_component "Rust 工具链" "
          curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y &&
          source \$HOME/.cargo/env &&
          rustup update
        " "command -v rustc"
        ;;
      "fzf (模糊搜索工具)")
        install_component "fzf" "
          git clone --depth 1 https://github.com/junegunn/fzf.git \$HOME/.fzf &&
          \$HOME/.fzf/install --all
        " "command -v fzf"
        ;;
      "tmux plugin manager (tpm)")
        install_component "tmux plugin manager" "
          git clone --depth 1 https://github.com/tmux-plugins/tpm \$HOME/.tmux/plugins/tpm
        " "[ -d \$HOME/.tmux/plugins/tpm ]"
        ;;
      "Cargo 工具 (多个包)")
        if ! command -v rustc &>/dev/null; then
          echo -e "${RED}[依赖缺失] Cargo 工具需要 Rust 工具链，请先安装 Rust 工具链。${NC}"
          failed_components+=("Cargo 工具 (缺少 Rust 工具链)")
          continue
        fi
        install_cargo_packages
        ;;
    esac
    sleep 1
  done
  setup_dotfiles
  sleep 2
}


# 启动交互流程
show_title
show_welcome_message
display_menu
get_user_selection

# 清屏并确认用户选择
clear_screen
show_title
echo -e "\n${CYAN}您选择了以下组件：${NC}"
for item in "${selected[@]}"; do
  echo -e "${YELLOW}- $item${NC}"
done
read -p "按回车键开始安装..."

# 执行安装
start_installation

# 安装完成提示
clear_screen
show_title
echo -e "${GREEN}
🎉 所有选定组件已安装完成！
===============================
🚀 请重新启动终端以确保所有配置生效！
===============================${NC}"

# 输出失败的组件和详细错误
if [ "${#failed_components[@]}" -ne 0 ]; then
  echo -e "${RED}以下组件安装失败：${NC}"
  for failed in "${failed_components[@]}"; do
    echo -e "${YELLOW}- $failed${NC}"
  done

  echo -e "\n${RED}错误详情：${NC}"
  for error in "${error_messages[@]}"; do
    echo -e "${YELLOW}- $error${NC}"
  done
fi