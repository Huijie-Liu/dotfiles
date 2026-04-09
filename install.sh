#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="${HOME:?}"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"

ROOT_LINKS=(
  ".zshrc:.zshrc"
  ".tmux.conf:.tmux.conf"
  ".condarc:.condarc"
)

backup_path() {
  local dest="$1"
  local backup="${dest}.bak.${TIMESTAMP}"

  mv "$dest" "$backup"
  echo "Backed up: $dest -> $backup"
}

link_path() {
  local rel_src="$1"
  local dest="$2"
  local src="$DOTFILES_DIR/$rel_src"

  if [[ ! -e "$src" ]]; then
    echo "Skip missing source: $src"
    return 0
  fi

  mkdir -p "$(dirname "$dest")"

  if [[ -L "$dest" ]]; then
    local current_target
    current_target="$(readlink "$dest")"

    if [[ "$current_target" == "$src" ]]; then
      echo "Unchanged: $dest"
      return 0
    fi

    rm "$dest"
  elif [[ -e "$dest" ]]; then
    backup_path "$dest"
  fi

  ln -s "$src" "$dest"
  echo "Linked: $dest -> $src"
}

link_root_paths() {
  local entry rel_src dest_rel

  for entry in "${ROOT_LINKS[@]}"; do
    IFS=":" read -r rel_src dest_rel <<<"$entry"
    link_path "$rel_src" "$HOME_DIR/$dest_rel"
  done
}

link_config_tree() {
  local path name

  mkdir -p "$HOME_DIR/.config"

  for path in "$DOTFILES_DIR/.config"/*; do
    [[ -e "$path" ]] || continue
    name="$(basename "$path")"
    link_path ".config/$name" "$HOME_DIR/.config/$name"
  done
}

main() {
  link_root_paths
  link_config_tree

  echo "Bootstrap complete."
  echo "Existing files were backed up with the suffix .bak.${TIMESTAMP} when needed."
}

main "$@"
