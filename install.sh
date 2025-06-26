#!/bin/bash

# =============================================================================
# Dotfiles Installation Script
# Creates symlinks for all configuration files in ~/.dotfiles to appropriate locations
# =============================================================================

set -euo pipefail

# =============================================================================
# Configuration
# =============================================================================

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Directories
readonly DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly HOME_DIR="$HOME"

# Dotfiles to link (excluding .config and .git)
readonly ROOT_DOTFILES=(
  ".zshrc"
  ".tmux.conf"
  ".condarc"
)

# =============================================================================
# Utility Functions
# =============================================================================

# Print colored message
print_message() {
  local color="$1"
  local message="$2"
  echo -e "${color}${message}${NC}"
}

# Print section header
print_header() {
  print_message "$BLUE" "\n$1"
  print_message "$BLUE" "$(printf '=%.0s' {1..50})"
}

# Print info message
print_info() {
  print_message "$BLUE" "$1"
}

# Print success message
print_success() {
  print_message "$GREEN" "$1"
}

# Print warning message
print_warning() {
  print_message "$YELLOW" "$1"
}

# Print error message
print_error() {
  print_message "$RED" "$1"
}

# =============================================================================
# Core Functions
# =============================================================================

# Create symlink with backup and directory creation
create_symlink() {
  local -r src_path="$1"
  local -r target_path="$2"
  local -r target_dir="$(dirname "$target_path")"

  # Create target directory if it doesn't exist
  if [[ ! -d "$target_dir" ]]; then
    print_info "📁 Creating directory: $target_dir"
    mkdir -p "$target_dir"
  fi

  # Handle existing target
  if [[ -e "$target_path" || -L "$target_path" ]]; then
    if [[ -L "$target_path" ]]; then
      local current_link
      current_link="$(readlink "$target_path")"
      if [[ "$current_link" == "$src_path" ]]; then
        print_success "✅ Already linked: $(basename "$target_path")"
        return 0
      else
        print_warning "🔄 Updating symlink: $(basename "$target_path")"
        rm "$target_path"
      fi
    else
      local backup_file="${target_path}.backup.$(date +%Y%m%d_%H%M%S)"
      print_warning "💾 Backing up: $(basename "$target_path") -> $(basename "$backup_file")"
      mv "$target_path" "$backup_file"
    fi
  fi

  # Create the symlink
  ln -s "$src_path" "$target_path"
  print_success "🔗 Linked: $(basename "$target_path") -> $src_path"
}

# Link .config directory contents
link_config_files() {
  local -r config_source="$DOTFILES_DIR/.config"
  local -r config_target="$HOME_DIR/.config"

  if [[ ! -d "$config_source" ]]; then
    print_warning "⚠️  No .config directory found in dotfiles"
    return 0
  fi

  print_header "📂 Linking .config files"

  # Find all items in .config (excluding hidden directories)
  while IFS= read -r -d '' item; do
    local basename
    basename="$(basename "$item")"
    create_symlink "$item" "$config_target/$basename"
  done < <(find "$config_source" -mindepth 1 -maxdepth 1 -not -name '.*' -print0)
}

# Link root dotfiles
link_root_dotfiles() {
  print_header "📄 Linking root dotfiles"

  for dotfile in "${ROOT_DOTFILES[@]}"; do
    local src_file="$DOTFILES_DIR/$dotfile"
    local target_file="$HOME_DIR/$dotfile"

    if [[ -f "$src_file" ]]; then
      create_symlink "$src_file" "$target_file"
    else
      print_warning "⚠️  File not found: $src_file"
    fi
  done
}

# =============================================================================
# Main Function
# =============================================================================

main() {
  print_header "🚀 Dotfiles Installation Script"
  print_info "Dotfiles directory: $DOTFILES_DIR"
  print_info "Home directory: $HOME_DIR"

  # Link configuration files
  link_config_files
  link_root_dotfiles

  # Success message
  print_header "✨ Installation completed successfully!"
  print_info "💡 Note: Original files are backed up with timestamp suffix"
  print_info "🔧 Restart your shell to apply changes"
}

# =============================================================================
# Script Entry Point
# =============================================================================

# Ensure script is not being sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
else
  echo "This script should be executed, not sourced." >&2
  exit 1
fi
