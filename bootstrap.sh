#!/bin/bash
#
# bootstrap.sh — single-command Linux setup (nix + home-manager)
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/Huijie-Liu/dotfiles/linux/bootstrap.sh | bash
#   curl -fsSL https://cdn.jsdelivr.net/gh/Huijie-Liu/dotfiles@linux/bootstrap.sh | bash  # China

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

GITHUB_REPO="https://github.com/Huijie-Liu/dotfiles.git"
GHPROXY_REPO="https://mirror.ghproxy.com/https://github.com/Huijie-Liu/dotfiles.git"
NIX_INSTALL_URL="https://nixos.org/nix/install"
NIX_INSTALL_GHPROXY="https://mirror.ghproxy.com/https://nixos.org/nix/install"
REPO_BRANCH="linux"

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

install_nix() {
  header "Install Nix"

  if command -v nix &>/dev/null; then
    success "Nix already installed: $(nix --version)"
    return 0
  fi

  local install_url="$NIX_INSTALL_URL"
  if detect_china; then
    install_url="$NIX_INSTALL_GHPROXY"
  fi

  info "Installing nix (multi-user)..."
  if sh <(curl -fsSL "$install_url") --daemon --yes; then
    success "Nix installed"
  else
    if [[ "$install_url" != "$NIX_INSTALL_GHPROXY" ]]; then
      warn "Direct install failed, trying ghproxy..."
      sh <(curl -fsSL "$NIX_INSTALL_GHPROXY") --daemon --yes || die "Nix install failed"
    else
      die "Nix install failed"
    fi
  fi

  # Make nix usable in this shell without re-login
  export PATH="/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:$PATH"

  # Ensure flakes are enabled
  if [[ -e /etc/nix/nix.conf ]] && ! grep -q 'experimental-features' /etc/nix/nix.conf; then
    echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf >/dev/null
  fi

  success "Nix ready"
}

setup_home_manager() {
  header "Home Manager"

  local flake="$DOTFILES_DIR/.config/home-manager"
  [[ -e "$flake/flake.nix" ]] || { warn "No flake at $flake, skip"; return 0; }

  info "First switch fetches nixpkgs, may take a while..."
  nix --extra-experimental-features "nix-command flakes" \
    run "$flake#home-manager" -- switch --flake "$flake#jay"
  success "Home Manager switched"
}

setup_shell() {
  header "Configure shell"

  local fish_path="$HOME/.nix-profile/bin/fish"
  if [[ ! -x "$fish_path" ]]; then
    warn "fish not found in nix profile, skip"
    return 0
  fi

  if ! grep -qF "$fish_path" /etc/shells 2>/dev/null; then
    echo "$fish_path" | sudo tee -a /etc/shells >/dev/null
  fi

  chsh -s "$fish_path"
  success "Default shell set to fish"
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
  echo ""
  echo "  Next steps:"
  echo "    • Create ~/.config/fish/conf.d/secrets.fish for API keys"
  echo "    • Restart terminal or exec fish"
  echo ""
  echo "  Update packages (edit .config/home-manager/home.nix first):"
  echo "    nix run ~/.dotfiles/.config/home-manager#home-manager -- switch --flake ~/.dotfiles/.config/home-manager#jay"
  echo ""
}

main() {
  echo ""
  printf "${BOLD}🐧 Dotfiles Bootstrap (Linux, nix + home-manager)${NC}\n"
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

  install_nix
  link_dotfiles
  setup_home_manager
  setup_shell
  print_summary
}

main "$@"
