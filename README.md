# Development Environment Configuration 🚀

This repository contains my personal development environment setup for macOS systems, featuring terminal configurations, shell customizations, editor setups, and productivity tools.

**Note:** These configurations are tailored to my workflow. Use selectively and with caution!

## Quick Start

### Clone Repository

```bash
git clone --branch macos https://github.com/Huijie-Liu/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### Automatic Installation

```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install all packages and applications via Brewfile
brew bundle install
```

<details>
<summary>🌏 Installation without proxy</summary>

If you're in China and experiencing slow download speeds, use these mirror sources:

```bash
# Set Homebrew mirror sources
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"

# Install Homebrew with mirror
/bin/bash -c "$(curl -fsSL https://github.com/Homebrew/install/raw/HEAD/install.sh)"

# Install all packages and applications via Brewfile
brew bundle install
```

</details>

## Features

- **macOS Optimization**: Custom configurations for Apple Silicon devices
- **One-Click Setup**: Automated installation of essential development tools
- **Modular Design**: Organized configuration files for easy customization
- **Unified Theme**: Consistent visual style across all tools
- **Keyboard-Driven**: Focus on keyboard shortcuts for maximum efficiency
- **Multi-Language Support**: Documentation in both English and Chinese

## Directory Structure

```
.
├── README.md                   # Main documentation
├── README.zh-CN.md             # Chinese documentation
├── Brewfile                    # Homebrew package definitions
├── .scripts/                   # Custom utility scripts
├── .config/                    # Application configurations
│   ├── aerospace/              # Window manager config
│   ├── alacritty/              # Alacritty terminal config
│   ├── atuin/                  # Shell history manager
│   ├── fish/                   # Fish shell config
│   ├── ghostty/                # Ghostty terminal config
│   ├── nvim/                   # Neovim IDE config
│   ├── sketchybar/             # macOS status bar config
│   ├── skhd/                   # Hotkey daemon config
│   ├── starship.toml           # Shell prompt config
│   ├── wezterm/                # Wezterm terminal config
│   ├── yabai/                  # Tiling WM config (legacy)
│   ├── zellij/                 # Terminal multiplexer config
│   └── zsh/                    # Zsh shell config
├── .tmux.conf                  # Tmux configuration
├── .zshrc                      # Zsh configuration
└── LICENSE                     # MIT License
```

## Core Components

### Terminal Ecosystem

- **Shells**:
  - Zsh with Oh My Zsh & Powerlevel10k
  - Fish with Tide prompt
  - Starship cross-shell prompt
- **Terminal Emulators**:
  - Alacritty
  - Wezterm
  - Ghostty
  - iTerm2
- **Multiplexers**:
  - Tmux
  - Zellij

### CLI Toolchain

- **Productivity Boosters**:
  - `fzf` (fuzzy finder)
  - `bat` (syntax highlighting)
  - `eza` (modern ls)
  - `zoxide` (smart cd)
  - `atuin` (shell history manager)
- **Git Enhancements**:
  - `lazygit` (TUI interface)
  - `delta` (diff viewer)

### macOS Exclusive

- **Window Management**:
  - Aerospace (tiling WM, Yabai alternative)
  - SKHD (hotkey daemon)
  - Sketchybar (custom menu bar)
- **System Enhancements**:
  - Raycast (launcher)
  - BetterTouchTool (input customization)
  - Bartender (menu bar management)

## Customization Guide

1. **Modify Configurations**:

   - Edit files in `~/.config/`
   - Adjust shell configs (`~/.zshrc`, `~/.config/fish`)

2. **Add New Tools**:

   - Add packages to `Brewfile`
   - Run `brew bundle install` to install new packages
   - Create corresponding config directories

3. **Theme Adjustments**:

   - Modify `starship.toml` for prompt
   - Edit terminal color schemes in respective config directories

4. **Package Management**:
   - Use `brew bundle dump --force` to update Brewfile with current packages
   - Use `brew bundle cleanup` to remove packages not in Brewfile

## License

Distributed under MIT License. See [LICENSE](LICENSE) for details.
