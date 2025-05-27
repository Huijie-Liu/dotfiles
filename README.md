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
# macOS
bash setup.sh
```

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
├── setup.sh                    # macOS automation script
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

## Installation Guide

### macOS Setup

The installation script (`setup.sh`) handles:

1. **Essential Packages**:
   - Homebrew package manager
   - Core development tools

2. **GUI Applications**:
   - Terminal emulators (iTerm2, Alacritty, Wezterm, Ghostty)
   - Productivity utilities

3. **Shell Environments**:
   - Zsh/Fish configurations
   - Starship cross-shell prompt

4. **Window Management**:
   - Aerospace/SKHD/Sketchybar trio
   - Auto-configured key bindings

## Customization Guide

1. **Modify Configurations**:
   - Edit files in `~/.config/`
   - Adjust shell configs (`~/.zshrc`, `~/.config/fish`)

2. **Add New Tools**:
   - Extend `setup.sh` with new packages
   - Create corresponding config directories

3. **Theme Adjustments**:
   - Modify `starship.toml` for prompt
   - Edit terminal color schemes in respective config directories

## Troubleshooting

If you encounter issues during installation:

1. Check the terminal output for specific error messages
2. Ensure you have proper permissions
3. For macOS-specific tools, verify your system version compatibility
4. Open an issue on GitHub with detailed information

## Contribution

Contributions are welcome! Please:

1. Open an issue for discussion
2. Keep configurations modular
3. Maintain cross-version compatibility
4. Test changes thoroughly before submitting PRs

## License

Distributed under MIT License. See [LICENSE](LICENSE) for details.

---

**Acknowledgments**: This setup stands on the shoulders of open-source giants. Special thanks to all tool maintainers and community contributors.
