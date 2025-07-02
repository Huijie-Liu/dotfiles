#!/bin/bash

# This script creates symlinks from the dotfiles .config directory to the user's ~/.config directory.
# It is designed to be run from within the .config directory itself.

# --- Configuration ---
# The directory where this script is located, which contains the config files.
CONFIG_SOURCE_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
# The target directory for the configuration files.
CONFIG_TARGET_DIR="$HOME/.config"
# The directory to back up any existing files that would be overwritten.
BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"

# --- Main Script ---
echo "Starting setup..."
echo "Source directory: $CONFIG_SOURCE_DIR"
echo "Target directory: $CONFIG_TARGET_DIR"
echo "Backup directory: $BACKUP_DIR"
echo ""

# Create the target and backup directories if they don't exist.
mkdir -p "$CONFIG_TARGET_DIR"
mkdir -p "$BACKUP_DIR"

# Loop through all items in the source directory.
for item_path in "$CONFIG_SOURCE_DIR"/*; do
  item_name=$(basename "$item_path")
  target_path="$CONFIG_TARGET_DIR/$item_name"

  # Skip the setup script itself.
  if [ "$item_name" = "setup.sh" ]; then
    echo "Skipping setup script itself."
    continue
  fi

  # Check if a file, directory, or symlink already exists at the target path.
  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    echo "Found existing item at $target_path. Moving it to backup directory."
    # Move the existing item to the backup directory.
    mv "$target_path" "$BACKUP_DIR/"
  fi

  # Create a symlink from the source item to the target path.
  echo "Creating symlink for $item_name -> $target_path"
  ln -s "$item_path" "$target_path"
done

echo ""
echo "Setup complete!"
echo "Symlinks have been created in $CONFIG_TARGET_DIR."
echo "Any pre-existing files were backed up to $BACKUP_DIR."
