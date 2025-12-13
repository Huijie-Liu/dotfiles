#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

ROOT_DOTFILES=(
  ".zshrc"
  ".tmux.conf"
  ".condarc"
)

create_link() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    mv "$dest" "${dest}.bak"
  fi

  ln -sf "$src" "$dest"
  echo "Linked: $dest -> $src"
}

for dotfile in "${ROOT_DOTFILES[@]}"; do
  [[ -f "$DOTFILES_DIR/$dotfile" ]] && create_link "$DOTFILES_DIR/$dotfile" "$HOME_DIR/$dotfile"
done

if [[ -d "$DOTFILES_DIR/.config" ]]; then
  for path in "$DOTFILES_DIR/.config"/*; do
    [[ -e "$path" ]] && create_link "$path" "$HOME_DIR/.config/$(basename "$path")"
  done
fi

echo "Done."
