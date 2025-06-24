#!/bin/bash

# Dotfiles installation script
# Creates symlinks for all configuration files in ~/.dotfiles to appropriate locations

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

echo -e "${BLUE}🔗 Dotfiles Installation Script${NC}"
echo -e "${BLUE}Dotfiles directory: ${DOTFILES_DIR}${NC}"
echo -e "${BLUE}Home directory: ${HOME_DIR}${NC}"
echo ""

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"

    # Create target directory if it doesn't exist
    local target_dir="$(dirname "$target")"
    if [[ ! -d "$target_dir" ]]; then
        echo -e "${YELLOW}📁 Creating directory: $target_dir${NC}"
        mkdir -p "$target_dir"
    fi

    # If target already exists
    if [[ -e "$target" || -L "$target" ]]; then
        if [[ -L "$target" ]]; then
            local current_link="$(readlink "$target")"
            if [[ "$current_link" == "$source" ]]; then
                echo -e "${GREEN}✅ Already linked: $target${NC}"
                return 0
            else
                echo -e "${YELLOW}🔄 Updating symlink: $target${NC}"
                rm "$target"
            fi
        else
            echo -e "${YELLOW}💾 Backing up existing file: $target${NC}"
            mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
        fi
    fi

    # Create the symlink
    ln -s "$source" "$target"
    echo -e "${GREEN}🔗 Created symlink: $target -> $source${NC}"
}

# Function to link .config directory contents
link_config_files() {
    local config_source="$DOTFILES_DIR/.config"
    local config_target="$HOME_DIR/.config"

    if [[ ! -d "$config_source" ]]; then
        echo -e "${YELLOW}⚠️  No .config directory found in dotfiles${NC}"
        return 0
    fi

    echo -e "${BLUE}📂 Linking .config files...${NC}"

    # Find all files and directories in .config (excluding .git and other hidden dirs)
    find "$config_source" -mindepth 1 -maxdepth 1 -not -name '.*' | while read -r item; do
        local basename="$(basename "$item")"
        local source="$item"
        local target="$config_target/$basename"

        create_symlink "$source" "$target"
    done
}

# Function to link root dotfiles
link_root_dotfiles() {
    echo -e "${BLUE}📄 Linking root dotfiles...${NC}"

    # List of dotfiles to link (excluding .config and .git)
    local dotfiles=(
        ".zshrc"
        ".tmux.conf"
        ".condarc"
    )

    for dotfile in "${dotfiles[@]}"; do
        local source="$DOTFILES_DIR/$dotfile"
        local target="$HOME_DIR/$dotfile"

        if [[ -f "$source" ]]; then
            create_symlink "$source" "$target"
        else
            echo -e "${YELLOW}⚠️  File not found: $source${NC}"
        fi
    done
}

# Main execution
main() {
    echo -e "${BLUE}🚀 Starting dotfiles installation...${NC}"
    echo ""

    # Link .config files
    link_config_files
    echo ""

    # Link root dotfiles
    link_root_dotfiles
    echo ""

    echo -e "${GREEN}✨ Dotfiles installation completed!${NC}"
    echo -e "${BLUE}💡 Note: Backup files are created with timestamp suffix if originals existed${NC}"
}

# Run main function
main "$@"
