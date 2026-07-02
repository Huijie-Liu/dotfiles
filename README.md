# Dotfiles

One-command setup for a new Mac:

## Quick Start

```bash
# Outside China — GitHub direct
curl -fsSL https://raw.githubusercontent.com/Huijie-Liu/dotfiles/macos/bootstrap.sh | bash

# Inside China — jsDelivr CDN (recommended)
curl -fsSL https://cdn.jsdelivr.net/gh/Huijie-Liu/dotfiles@macos/bootstrap.sh | bash -s -- --china
```

This single command:

- Installs **Xcode Command Line Tools**
- Installs **Homebrew** (USTC mirrors when in China)
- Installs packages from `Brewfile` (if present)
- Installs **fish** and sets it as the default shell
- Configures **zsh** to read from `~/.config/zsh` (writes `~/.zshenv`)
- Symlinks all configs into `~/.config/` (existing files backed up as `*.bak.*`)
- Applies macOS preferences (key repeat, Dock auto-hide, etc.)

> **China notes**: The script auto-detects network environment. GitHub clone falls back to ghproxy; Homebrew falls back to USTC mirrors. Use `--china` to skip detection and force mirrors.

### Options

| Flag | Description |
|------|-------------|
| `... \| bash -s -- --china` | Force China mirrors |
| `... \| bash -s -- --dotfiles-only` | Only symlink configs, skip all installs |
| `... \| bash -s -- --skip-brew` | Skip Brewfile package install |

Combine as needed: `bash -s -- --china --dotfiles-only`

### Already cloned?

```bash
cd ~/.dotfiles
./bootstrap.sh                     # Full setup
./bootstrap.sh --dotfiles-only     # Just re-link configs
```

## What's Included

### Core Tools

- **Shells**: Zsh, Fish with Starship prompt
- **Terminals**: Alacritty, Wezterm, Ghostty
- **Multiplexers**: Tmux, Zellij
- **Editor**: Neovim with LazyVim

### CLI Productivity

- `fzf`, `bat`, `eza`, `zoxide`
- `lazygit`, `git-delta` for Git workflow
- `btop`, `dust`, `fd`, `ripgrep`

### macOS Enhancements

- **Aerospace**: Tiling window manager
- **SKHD**: Hotkey daemon
- **Sketchybar**: Custom menu bar

## Customization

- **Configs**: Edit files under `~/.dotfiles/.config/` — symlinks in `~/.config/` follow automatically
- **Packages**: Update `Brewfile` and run `brew bundle --file Brewfile`
- **Export**: Run `brew bundle dump --force` to snapshot installed packages

## License

MIT. See [LICENSE](LICENSE) for details.
