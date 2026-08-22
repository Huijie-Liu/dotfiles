#!/bin/bash
#
# bootstrap.sh — single-command Linux setup (pixi + npm)
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/Huijie-Liu/dotfiles/linux/bootstrap.sh | bash
#   curl -fsSL https://cdn.jsdelivr.net/gh/Huijie-Liu/dotfiles@linux/bootstrap.sh | bash  # China
#
# 会询问 sudo 密码（仅 chsh 需要）。工具清单：
#   pixi global (conda-forge, ~/.pixi/bin):
#     fish nodejs nvim zellij yazi lazygit lazydocker fastfetch
#     ripgrep fd-find jq ffmpeg imagemagick poppler 7zip zoxide gh resvg codex
#   npm global (~/.local, prefix=~/.local):
#     claude-code、dsh（conda-forge 无 linux 构建 / 无此包，例外走 npm）

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

GITHUB_REPO="https://github.com/Huijie-Liu/dotfiles.git"
GHPROXY_REPO="https://mirror.ghproxy.com/https://github.com/Huijie-Liu/dotfiles.git"
REPO_BRANCH="linux"
PIXI_BIN="$HOME/.pixi/bin"
LOCAL_BIN="$HOME/.local/bin"

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

info()    { printf "${BLUE}[INFO]${NC} %s\n" "$*"; }
success() { printf "${GREEN}[OK]${NC} %s\n" "$*"; }
warn()    { printf "${YELLOW}[WARN]${NC} %s\n" "$*"; }
error()   { printf "${RED}[ERROR]${NC} %s\n" "$*" >&2; }
header()  { printf "\n${BOLD}━━━ %s ━━━${NC}\n" "$*"; }

die() { error "$*"; exit 1; }

detect_china() {
  if $CHINA_MIRROR; then return 0; fi
  local ipinfo
  ipinfo="$(curl -s --connect-timeout 3 --max-time 5 https://ipapi.co/country_code/ 2>/dev/null || true)"
  [[ "$ipinfo" == "CN" ]] && return 0
  return 1
}

sudo_keep_alive() {
  sudo -v
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

clone_dotfiles() {
  header "Clone dotfiles"
  local clone_url="$GITHUB_REPO"
  if detect_china; then
    clone_url="$GHPROXY_REPO"
  fi

  if git clone --branch "$REPO_BRANCH" "$clone_url" "$DOTFILES_DIR" 2>/dev/null; then
    success "Cloned to $DOTFILES_DIR"
    return 0
  fi

  if [[ "$clone_url" != "$GHPROXY_REPO" ]]; then
    warn "GitHub failed, trying ghproxy..."
    if git clone --branch "$REPO_BRANCH" "$GHPROXY_REPO" "$DOTFILES_DIR" 2>/dev/null; then
      git -C "$DOTFILES_DIR" remote set-url origin "$GITHUB_REPO"
      success "Cloned via ghproxy to $DOTFILES_DIR"
      return 0
    fi
  fi

  die "Clone failed. Check network or clone manually to ~/.dotfiles"
}

install_pixi() {
  header "Install pixi"

  if command -v pixi &>/dev/null; then
    success "pixi already installed: $(pixi --version)"
  else
    curl -fsSL https://pixi.sh/install.sh | bash
    success "pixi installed"
  fi

  export PATH="$PIXI_BIN:$PATH"
}

pixi_global_install() {
  header "Install tools via pixi global (conda-forge)"

  local tools=(fish nodejs nvim zellij yazi lazygit lazydocker fastfetch ripgrep fd-find jq ffmpeg imagemagick poppler 7zip zoxide gh resvg codex)
  info "Installing: ${tools[*]}"
  pixi global install "${tools[@]}"
  success "pixi tools installed to $PIXI_BIN"
}

install_npm_tools() {
  header "Install npm tools (claude-code / dsh)"

  mkdir -p "$LOCAL_BIN"
  npm config set prefix "$HOME/.local"

  info "claude-code..."
  npm install -g --allow-scripts=@anthropic-ai/claude-code @anthropic-ai/claude-code
  info "dsh..."
  npm install -g --allow-scripts=@deepseek-ai/dsh-subprocess-local,koffi,node-pty,@google/genai,protobufjs @deepseek-ai/dsh
  success "npm tools installed to $LOCAL_BIN"
}

setup_shell() {
  header "Configure shell"

  local fish_path="$PIXI_BIN/fish"
  if ! grep -qF "$fish_path" /etc/shells 2>/dev/null; then
    echo "$fish_path" | sudo tee -a /etc/shells >/dev/null
  fi

  chsh -s "$fish_path"
  success "Default shell set to $fish_path"
}

link_dotfiles() {
  header "Link configs"

  local timestamp
  timestamp="$(date +%Y%m%d%H%M%S)"

  backup_path() {
    local bak="${1}.bak.${timestamp}"
    mv "$1" "$bak"
    info "Backed up: $1 -> $bak"
  }

  link_path() {
    local src="$DOTFILES_DIR/$1"
    local dest="$2"

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

  success "$(ls "$DOTFILES_DIR/.config" | wc -l | tr -d ' ') configs linked"
}

print_summary() {
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  ${GREEN}✨ Bootstrap complete!${NC}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  echo "  Configs linked to: ${BOLD}$HOME/.config/${NC}"
  echo "  Dotfiles dir:      ${BOLD}$DOTFILES_DIR${NC}"
  echo "  Default shell:     ${BOLD}fish${NC} (re-login to apply)"
  echo "  pixi binaries:     ${BOLD}$PIXI_BIN${NC}"
  echo "  npm binaries:      ${BOLD}$LOCAL_BIN${NC}"
  echo ""
  echo "  Next steps:"
  echo "    • Create ~/.config/fish/conf.d/secrets.fish for API keys"
  echo "    • Restart terminal or exec fish"
  echo ""
  echo "  Update packages:"
  echo "    pixi global upgrade-all"
  echo "    pixi self-update"
  echo "    npm install -g @anthropic-ai/claude-code @deepseek-ai/dsh"
  echo ""
}

main() {
  echo ""
  printf "${BOLD}🐧 Dotfiles Bootstrap (Linux, pixi + npm)${NC}\n"
  echo ""

  if [[ -n "${DOTFILES_DIR:-}" ]]; then
    true
  elif [[ -d "$(dirname "$0")/.config" ]]; then
    DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
  else
    DOTFILES_DIR="$HOME/.dotfiles"
    if [[ ! -d "$DOTFILES_DIR" ]]; then
      clone_dotfiles
    else
      info "Repo exists: $DOTFILES_DIR"
      git -C "$DOTFILES_DIR" pull --rebase origin "$REPO_BRANCH" 2>/dev/null || \
        warn "Pull failed, using existing version"
    fi
  fi

  export DOTFILES_DIR
  sudo_keep_alive

  if $DOTFILES_ONLY; then
    link_dotfiles
    print_summary
    exit 0
  fi

  install_pixi
  pixi_global_install
  install_npm_tools
  link_dotfiles
  setup_shell
  print_summary
}

main "$@"
