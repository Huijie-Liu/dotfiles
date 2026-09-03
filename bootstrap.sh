#!/usr/bin/env bash
#
# bootstrap.sh — 一行命令配置新 Linux 电脑（pixi + npm）
#
# 用法（任选一个）:
#   curl -fsSL https://raw.githubusercontent.com/Huijie-Liu/dotfiles/linux/bootstrap.sh | bash
#   curl -fsSL https://cdn.jsdelivr.net/gh/Huijie-Liu/dotfiles@linux/bootstrap.sh | bash  # 国内推荐
#
# 参数:
#   --china         强制使用国内镜像
#   --dotfiles-only 只链接配置文件
#
# 工具清单:
#   pixi global (conda-forge, ~/.pixi/bin):
#     fish nodejs nvim zellij yazi lazygit lazydocker fastfetch
#     ripgrep fd-find jq ffmpeg imagemagick poppler 7zip zoxide gh resvg codex
#   npm global (~/.local, prefix=~/.local):
#     claude-code、dsh（conda-forge 无 linux 构建 / 无此包，例外走 npm）

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
GHPROXY_PREFIX="https://mirror.ghproxy.com"
GHPROXY_REPO="$GHPROXY_PREFIX/$GITHUB_REPO"
REPO_BRANCH="linux"
PIXI_BIN="$HOME/.pixi/bin"
LOCAL_BIN="$HOME/.local/bin"

# ── 参数解析 ──────────────────────────────────────────
CHINA_MIRROR=false
DOTFILES_ONLY=false

for arg in "$@"; do
  case "$arg" in
    --china)         CHINA_MIRROR=true ;;
    --dotfiles-only) DOTFILES_ONLY=true ;;
    --help|-h)
      echo "Usage: $0 [--china] [--dotfiles-only]"
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
  [[ "$ipinfo" == "CN" ]]
}

# ── 获取 sudo 权限（后台保活） ────────────────────────
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

# ── 确定 dotfiles 目录 ────────────────────────────────
# curl | bash 时 $0 是 "bash"，不能拿它定位脚本目录 —— 只有 $0 是
# 真实文件且旁边有 .config 时才认为是本地 clone，否则默认 ~/.dotfiles。
resolve_dotfiles_dir() {
  if [[ -n "${DOTFILES_DIR:-}" ]]; then
    info "使用指定目录: $DOTFILES_DIR"
  elif [[ -f "$0" && -d "$(dirname "$0")/.config" ]]; then
    DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
    info "使用脚本所在仓库: $DOTFILES_DIR"
  else
    DOTFILES_DIR="$HOME/.dotfiles"
    if [[ -d "$DOTFILES_DIR" ]]; then
      info "仓库已存在: $DOTFILES_DIR"
      git -C "$DOTFILES_DIR" pull --rebase origin "$REPO_BRANCH" 2>/dev/null ||
        warn "无法更新仓库（网络不通？），使用已有版本继续"
    else
      clone_dotfiles
    fi
  fi

  export DOTFILES_DIR
}

# ── 安装 pixi ─────────────────────────────────────────
install_pixi() {
  header "安装 pixi"

  if command -v pixi &>/dev/null; then
    success "pixi 已安装: $(pixi --version)"
    export PATH="$PIXI_BIN:$PATH"
    return 0
  fi

  command -v curl &>/dev/null || die "未找到 curl，请先安装 curl"

  local installer="/tmp/pixi-install-$$.sh"
  curl -fsSL https://pixi.sh/install.sh -o "$installer" ||
    die "下载 pixi 安装脚本失败，请检查网络后重试"

  if detect_china; then
    # pixi 二进制托管在 GitHub releases；国内先走 ghproxy 加速，失败再直连
    local arch=""
    case "$(uname -m)" in
      x86_64)        arch="x86_64-unknown-linux-musl" ;;
      aarch64|arm64) arch="aarch64-unknown-linux-musl" ;;
    esac
    if [[ -n "$arch" ]]; then
      local asset="https://github.com/prefix-dev/pixi/releases/latest/download/pixi-$arch"
      if PIXI_DOWNLOAD_URL="$GHPROXY_PREFIX/$asset" bash "$installer"; then
        rm -f "$installer"
        export PATH="$PIXI_BIN:$PATH"
        success "pixi 安装完成（ghproxy 加速）"
        return 0
      fi
      warn "ghproxy 下载失败，尝试直连..."
    fi
  fi

  bash "$installer" || die "pixi 安装失败，请检查网络后重试"
  rm -f "$installer"
  export PATH="$PIXI_BIN:$PATH"
  success "pixi 安装完成"
}

# ── 安装 CLI 工具（pixi global） ──────────────────────
pixi_global_install() {
  header "安装 CLI 工具（pixi global / conda-forge）"

  local tools=(fish nodejs nvim zellij yazi lazygit lazydocker fastfetch ripgrep fd-find jq ffmpeg imagemagick poppler 7zip zoxide gh resvg codex)
  info "安装: ${tools[*]}"
  pixi global install "${tools[@]}" ||
    warn "部分工具安装失败，可稍后手动运行: pixi global install ${tools[*]}"
  success "pixi 工具已安装到 $PIXI_BIN"
}

# ── 安装 npm 工具 ─────────────────────────────────────
install_npm_tools() {
  header "安装 npm 工具（claude-code / dsh）"

  command -v npm &>/dev/null || die "未找到 npm（pixi_global_install 应已装好 nodejs）"

  mkdir -p "$LOCAL_BIN"
  npm config set prefix "$HOME/.local"

  if detect_china; then
    info "使用 npmmirror 镜像"
    npm config set registry https://registry.npmmirror.com
  fi

  info "claude-code..."
  npm install -g --allow-scripts=@anthropic-ai/claude-code @anthropic-ai/claude-code
  info "dsh..."
  npm install -g --allow-scripts=@deepseek-ai/dsh-subprocess-local,koffi,node-pty,@google/genai,protobufjs @deepseek-ai/dsh
  success "npm 工具已安装到 $LOCAL_BIN"
}

# ── 修复 conda-forge nvim 的 libunibilium 链接错误 ────
# 当前 conda-forge 打包的 nvim 二进制 DT_NEEDED 写成了
# 'libunibilium.so..'（多一个点），环境里只有 libunibilium.so.4，
# 启动直接报错。打包修复后此函数自然成为空操作。
fix_nvim_unibilium() {
  local lib="$HOME/.pixi/envs/nvim/lib"
  if [[ -f "$lib/libunibilium.so.4" && ! -e "$lib/libunibilium.so.." ]]; then
    ln -s libunibilium.so.4 "$lib/libunibilium.so.."
    info "已修复 conda-forge nvim 的 libunibilium 链接问题"
  fi
}

# ── 设置 Fish Shell 为默认 ────────────────────────────
setup_shell() {
  header "配置 Shell"

  [[ -x "$PIXI_BIN/fish" ]] || die "未找到 fish（pixi_global_install 应已安装）"

  # 添加到 /etc/shells
  if ! grep -qF "$PIXI_BIN/fish" /etc/shells 2>/dev/null; then
    info "将 $PIXI_BIN/fish 添加到 /etc/shells"
    echo "$PIXI_BIN/fish" | sudo tee -a /etc/shells >/dev/null
  fi

  # 走 sudo，免去 chsh 的独立密码校验，全程只需开头一次
  sudo chsh -s "$PIXI_BIN/fish" "$(id -un)"
  success "默认 shell 已切换为 fish"
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

# ── 打印总结 ─────────────────────────────────────────
print_summary() {
  printf "\n"
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  printf "  ${GREEN}Bootstrap 完成!${NC}\n"
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
  printf "  配置文件已链接到: ${BOLD}%s${NC}\n" "$HOME/.config/"
  printf "  Dotfiles 目录:    ${BOLD}%s${NC}\n" "$DOTFILES_DIR"
  printf "  pixi 二进制:      ${BOLD}%s${NC}\n" "$PIXI_BIN"
  printf "  npm 二进制:       ${BOLD}%s${NC}\n" "$LOCAL_BIN"
  printf "\n"
  printf "  默认 shell: ${BOLD}fish${NC} — 重新登录生效\n\n"
  printf "  后续步骤:\n"
  printf "    • 编辑 ~/.dotfiles/.config/ 下的文件来定制配置\n"
  printf "    • 创建 ~/.config/fish/conf.d/secrets.fish 并填入 API keys\n"
  printf "    • 重启终端或 exec fish\n\n"
  printf "  更新包:\n"
  printf "    pixi global upgrade-all && pixi self-update\n"
  printf "    npm install -g @anthropic-ai/claude-code @deepseek-ai/dsh\n\n"
}

# ═════════════════════════════════════════════════════
# 主流程
# ═════════════════════════════════════════════════════

main() {
  echo ""
  printf "${BOLD}🐧 Dotfiles Bootstrap (Linux, pixi + npm)${NC}\n"
  echo ""

  resolve_dotfiles_dir

  if $DOTFILES_ONLY; then
    link_dotfiles
    print_summary
    return 0
  fi

  # 只有写 /etc/shells 和 chsh 需要 sudo；dotfiles-only 模式不需要
  sudo_keep_alive

  install_pixi
  pixi_global_install
  install_npm_tools
  fix_nvim_unibilium
  link_dotfiles
  setup_shell
  print_summary
}

main "$@"
