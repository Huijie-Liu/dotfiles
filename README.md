# Personal Dotfiles 🚀

My personal development environment setup for macOS, featuring terminal configurations, shell customizations, and productivity tools.

## Quick Start

```bash
# Clone repository
git clone --branch macos https://github.com/Huijie-Liu/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Install Homebrew (if needed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages and applications if Brewfile is present
[ -f Brewfile ] && brew bundle --file Brewfile

# Link configs into $HOME and ~/.config
./install.sh
```

### For China Users 🌏

Use USTC mirrors for faster downloads:

```bash
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"

/bin/bash -c "$(curl -fsSL https://github.com/Homebrew/install/raw/HEAD/install.sh)"
[ -f Brewfile ] && brew bundle --file Brewfile
./install.sh
```

## Bootstrap

`./install.sh` is the entrypoint for applying these dotfiles. It will:

- link root dotfiles such as `.zshrc`, `.tmux.conf`, and `.condarc`
- link every tracked entry under `.config/`
- back up existing files as `*.bak.TIMESTAMP` before replacing them

If you want Fish as the default shell after installing packages:

```bash
chsh -s /opt/homebrew/bin/fish
```

## What's Included

### Core Tools

- **Shells**: Zsh, Fish with modern prompts (Starship)
- **Terminals**: Alacritty, Wezterm, Ghostty
- **Multiplexers**: Tmux, Zellij
- **Editor**: Neovim with LazyVim

### CLI Productivity

- `fzf`, `bat`, `eza`, `zoxide`, `atuin`
- `lazygit`, `git-delta` for Git workflow
- `btop`, `dust`, `fd`, `ripgrep`

### macOS Enhancements

- **Aerospace**: Tiling window manager
- **SKHD**: Hotkey daemon
- **Sketchybar**: Custom menu bar
- **Karabiner**: Keyboard customization

## Customization

- **Configurations**: Edit the tracked files in `~/.dotfiles/`; the symlinks in `~/.config/` and `$HOME` will point back to them
- **Add Tools**: Update `Brewfile` and run `brew bundle --file Brewfile`
- **Themes**: Modify `starship.toml` and terminal color schemes
- **Package Management**: Use `brew bundle dump --force` to update Brewfile

## License

Distributed under MIT License. See [LICENSE](LICENSE) for details.
