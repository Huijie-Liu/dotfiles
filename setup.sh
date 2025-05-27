#!/usr/bin/env bash

set -euo pipefail

# ---------- 工具函数 ----------
info() { echo -e "\e[1;34m[INFO]\e[0m $*"; }
warn() { echo -e "\e[1;33m[WARN]\e[0m $*"; }
error() {
  echo -e "\e[1;31m[ERR ]\e[0m $*" >&2
  exit 1
}

install_pkg() {
  local pkg=$1
  if command -v apt >/dev/null 2>&1; then
    sudo apt-get update -qq && sudo apt-get install -y "$pkg"
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y "$pkg"
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --noconfirm "$pkg"
  else
    error "未识别的包管理器，请手动安装 $pkg"
  fi
}

# ---------- 依赖检查 ----------
for cmd in curl git; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    info "检测到未安装 $cmd，尝试安装..."
    install_pkg "$cmd"
  fi
done

# ---------- 安装 Rust (rustup) ----------
info "安装 Rust（rustup）..."
if ! command -v rustup >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
else
  info "Rust 已存在，跳过 rustup"
fi

# ---------- 安装 Atuin ----------
info "安装 Atuin（一键增强历史管理）..."
if ! command -v atuin >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | bash
else
  info "Atuin 已存在，跳过安装"
fi

# ---------- 安装 fzf ----------
info "安装 fzf（模糊搜索利器）..."
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --all
else
  info "目录 ~/.fzf 已存在，跳过克隆；确保执行安装脚本"
  "$HOME/.fzf/install" --all
fi

# ---------- 安装 Micromamba ----------
info "安装 Micromamba（轻量级 Conda 替代）..."
if ! command -v micromamba >/dev/null 2>&1; then
  "${SHELL}" <(curl -L micro.mamba.pm/install.sh)
else
  info "Micromamba 已存在，跳过安装"
fi

# ---------- 后续提示 ----------
cat <<'EOF'

==============================================
✅  所有组件已安装完成！
👉  请重启终端，或执行：
    source ~/.bashrc     # Bash 用户
    source ~/.zshrc      # Zsh  用户
然后你就可以开始愉快地编码啦 🚀
==============================================
EOF
