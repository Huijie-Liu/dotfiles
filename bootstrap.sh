#!/bin/bash
#
# bootstrap.sh — 一行命令配置新电脑
#
# 用法（任选一个）:
#   curl -fsSL https://raw.githubusercontent.com/Huijie-Liu/dotfiles/macos/bootstrap.sh | bash
#   curl -fsSL https://cdn.jsdelivr.net/gh/Huijie-Liu/dotfiles@macos/bootstrap.sh | bash  # 国内推荐
#
# 参数:
#   --china         强制使用国内镜像
#   --dotfiles-only 只链接配置文件
#   --skip-brew     跳过 brew 包安装

set -euo pipefail

# ── 颜色 ──────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

# ── Git 仓库地址 ──────────────────────────────────────
GITHUB_REPO="https://github.com/Huijie-Liu/dotfiles.git"
# ghproxy 国内加速（第三方服务，可能不稳定）
GHPROXY_REPO="https://mirror.ghproxy.com/https://github.com/Huijie-Liu/dotfiles.git"
REPO_BRANCH="macos"

# ── 参数解析 ──────────────────────────────────────────
CHINA_MIRROR=false
DOTFILES_ONLY=false
SKIP_BREW=false

for arg in "$@"; do
  case "$arg" in
    --china)         CHINA_MIRROR=true ;;
    --dotfiles-only) DOTFILES_ONLY=true ;;
    --skip-brew)     SKIP_BREW=true ;;
    --help|-h)
      echo "Usage: $0 [--china] [--dotfiles-only] [--skip-brew]"
      exit 0
      ;;
  esac
done

# ── 工具函数 ──────────────────────────────────────────
info()    { printf "${BLUE}[INFO]${NC} %s\n" "$*"; }
success() { printf "${GREEN}[OK]${NC} %s\n" "$*"; }
warn()    { printf "${YELLOW}[WARN]${NC} %s\n" "$*"; }
error()   { printf "${RED}[ERROR]${NC} %s\n" "$*" >&2; }
header()  { printf "\n${BOLD}━━━ %s ━━━${NC}\n" "$*"; }

die() {
  error "$*"
  exit 1
}

# ── 检测是否在中国 ────────────────────────────────────
detect_china() {
  if $CHINA_MIRROR; then
    return 0
  fi
  local ipinfo
  ipinfo="$(curl -s --connect-timeout 3 --max-time 5 https://ipapi.co/country_code/ 2>/dev/null || true)"
  if [[ "$ipinfo" == "CN" ]]; then
    return 0
  fi
  return 1
}

# ── 获取 sudo 权限 ────────────────────────────────────
sudo_keep_alive() {
  sudo -v
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &
}

# ── 克隆 dotfiles（国内优先走 ghproxy） ───────────────
clone_dotfiles() {
  header "克隆 dotfiles 仓库"

  local clone_url="$GITHUB_REPO"

  if detect_china; then
    clone_url="$GHPROXY_REPO"
    info "使用 ghproxy 镜像克隆"
  fi

  if git clone --branch "$REPO_BRANCH" "$clone_url" "$DOTFILES_DIR" 2>/dev/null; then
    success "仓库已克隆到 $DOTFILES_DIR"
    return 0
  fi

  # GitHub 直连失败，尝试 ghproxy
  if [[ "$clone_url" != "$GHPROXY_REPO" ]]; then
    warn "GitHub 直连失败，尝试 ghproxy 镜像..."
    if git clone --branch "$REPO_BRANCH" "$GHPROXY_REPO" "$DOTFILES_DIR" 2>/dev/null; then
      # 把 remote 改回 GitHub，方便后续使用代理或切回直连
      git -C "$DOTFILES_DIR" remote set-url origin "$GITHUB_REPO"
      success "仓库已通过 ghproxy 克隆到 $DOTFILES_DIR"
      return 0
    fi
  fi

  die "克隆失败。请检查网络，或手动克隆到 ~/.dotfiles 后重试"
}

# ── 安装 Xcode Command Line Tools ─────────────────────
install_xcode_clt() {
  if xcode-select -p &>/dev/null; then
    success "Xcode CLI tools 已安装"
    return 0
  fi

  header "安装 Xcode Command Line Tools"
  info "正在安装...（可能需要几分钟）"
  xcode-select --install 2>/dev/null || true

  until xcode-select -p &>/dev/null; do
    sleep 5
  done
  success "Xcode CLI tools 安装完成"
}

# ── 安装 Homebrew ─────────────────────────────────────
install_homebrew() {
  if command -v brew &>/dev/null; then
    success "Homebrew 已安装: $(brew --version | head -1)"
    return 0
  fi

  header "安装 Homebrew"
  local install_url

  if detect_china; then
    warn "检测到中国网络，使用 USTC 镜像"
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
    export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
    export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"

    # Homebrew 安装脚本也走国内镜像
    install_url="https://mirrors.ustc.edu.cn/brew-install/raw/HEAD/install.sh"
  else
    install_url="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
  fi

  /bin/bash -c "$(curl -fsSL "$install_url")"

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  success "Homebrew 安装完成"
}

# ── 安装 Brew 包 ─────────────────────────────────────
install_brew_packages() {
  header "安装 Homebrew 软件包"

  if [[ ! -f "$DOTFILES_DIR/Brewfile" ]]; then
    warn "未找到 Brewfile，跳过软件包安装"
    warn "之后可以手动创建 Brewfile 并运行: brew bundle --file ~/.dotfiles/Brewfile"
    return 0
  fi

  info "正在安装 Brewfile 中的软件包..."
  brew bundle --file "$DOTFILES_DIR/Brewfile" || warn "部分软件包安装失败，继续..."
  success "软件包安装完成"
}

# ── 安装 Fish Shell 并设为默认 ──────────────────────────
setup_shell() {
  header "配置 Shell"

  # 安装 fish
  if ! command -v fish &>/dev/null; then
    info "安装 fish..."
    brew install fish
  fi
  success "fish 已安装"

  # 添加到 /etc/shells
  local fish_path
  fish_path="$(command -v fish)"
  if ! grep -qF "$fish_path" /etc/shells 2>/dev/null; then
    info "将 $fish_path 添加到 /etc/shells"
    echo "$fish_path" | sudo tee -a /etc/shells >/dev/null
  fi

  # 设为默认
  chsh -s "$fish_path"
  success "默认 shell 已切换为 fish"

  # 给 zsh 设 ZDOTDIR，确保兼容
  if ! grep -qF 'ZDOTDIR' "$HOME/.zshenv" 2>/dev/null; then
    echo 'export ZDOTDIR="$HOME/.config/zsh"' >> "$HOME/.zshenv"
    success "ZDOTDIR 已写入 ~/.zshenv"
  fi
}

# ── 链接配置文件 ─────────────────────────────────────
link_dotfiles() {
  header "链接配置文件"

  local timestamp
  timestamp="$(date +%Y%m%d%H%M%S)"

  backup_path() {
    local dest="$1"
    local bak="${dest}.bak.${timestamp}"
    mv "$dest" "$bak"
    info "Backed up: $dest -> $bak"
  }

  link_path() {
    local rel="$1"
    local dest="$2"
    local src="$DOTFILES_DIR/$rel"

    if [[ ! -e "$src" ]]; then
      warn "Skip missing: $src"
      return 0
    fi

    mkdir -p "$(dirname "$dest")"

    if [[ -L "$dest" ]]; then
      if [[ "$(readlink "$dest")" == "$src" ]]; then
        return 0
      fi
      rm "$dest"
    elif [[ -e "$dest" ]]; then
      backup_path "$dest"
    fi

    ln -s "$src" "$dest"
    info "Linked: $dest -> $src"
  }

  mkdir -p "$HOME/.config"

  local path name
  for path in "$DOTFILES_DIR/.config"/*; do
    [[ -e "$path" ]] || continue
    name="$(basename "$path")"
    link_path ".config/$name" "$HOME/.config/$name"
  done

  success "$(ls "$DOTFILES_DIR/.config" | wc -l | tr -d ' ') 个配置已链接"
}

# ── 设置 macOS 默认值 ─────────────────────────────────
set_macos_defaults() {
  header "设置 macOS 偏好"

  defaults write NSGlobalDomain KeyRepeat -int 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 15
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.finder ShowPathbar -bool true

  killall Finder &>/dev/null || true
  killall Dock &>/dev/null || true

  success "macOS 偏好设置完成"
}

# ── 打印总结 ─────────────────────────────────────────
print_summary() {
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  ${GREEN}✨ Bootstrap 完成!${NC}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  echo "  配置文件已链接到: ${BOLD}$HOME/.config/${NC}"
  echo "  Dotfiles 目录:    ${BOLD}$DOTFILES_DIR${NC}"
  echo ""
  echo "  默认 shell: ${BOLD}fish${NC} — 重新登录生效"
  echo ""
  echo "  后续步骤:"
  echo "    • 编辑 ~/.dotfiles/.config/ 下的文件来定制配置"
  echo "    • 创建 ~/.config/fish/conf.d/secrets.fish 并填入 API keys"
  echo "    • 运行 brew bundle dump --force 导出已安装的包到 Brewfile"
  echo "    • 重启终端或 source 对应配置文件使其生效"
  echo ""
}

# ═══════════════════════════════════════════════════════
# 主流程
# ═══════════════════════════════════════════════════════

main() {
  echo ""
  printf "${BOLD}🚀 Dotfiles Bootstrap${NC}\n"
  echo ""

  # ── 确定 dotfiles 目录 ──
  if [[ -n "${DOTFILES_DIR:-}" ]]; then
    true
  elif [[ -d "$(dirname "$0")/.config" ]]; then
    DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
  else
    DOTFILES_DIR="$HOME/.dotfiles"
    if [[ ! -d "$DOTFILES_DIR" ]]; then
      clone_dotfiles
    else
      info "仓库已存在: $DOTFILES_DIR"
      git -C "$DOTFILES_DIR" pull --rebase origin "$REPO_BRANCH" 2>/dev/null || \
        warn "无法更新仓库（网络不通？），使用已有版本继续"
    fi
  fi

  export DOTFILES_DIR

  sudo_keep_alive

  if $DOTFILES_ONLY; then
    link_dotfiles
    print_summary
    exit 0
  fi

  install_xcode_clt
  install_homebrew

  if ! $SKIP_BREW; then
    install_brew_packages
  fi

  link_dotfiles
  setup_shell
  set_macos_defaults
  print_summary
}

main "$@"
