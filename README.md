# Development Environment Configuration 🚀

![Shell Integration](https://img.shields.io/badge/Shell-Zsh%20%7C%20Fish-blueviolet)
![Editor](https://img.shields.io/badge/Editor-Neovim-brightgreen)
![Package Manager](https://img.shields.io/badge/Package-Nix-orange)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository contains my cross-platform development environment configurations for terminal, shell, editors, and various productivity tools. Ideal for developers working across Linux/macOS systems.

**Disclaimer**: These configurations are opinionated and tailored to my workflow. Use them as a reference and adapt carefully to your needs.

## 🚀 Quick Start

### Prerequisites

- Git 2.0+
- Bash 4.0+
- curl/wget

### Clone Repository

```bash
git clone --branch linux https://github.com/Huijie-Liu/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### Automated Setup (Linux)

```bash
bash setup.sh
```

## ✨ Features

- **Cross-Platform Support**: Optimized for both Linux and macOS
- **Modern Toolchain**: Pre-configured development essentials
- **Modular Design**: Easy to enable/disable components
- **Unified UI**: Consistent theming across all tools
- **Reproducible**: Nix flake support for environment consistency

## 📂 Directory Structure

```text
.
├── .condarc                    # Conda configuration
├── .config/                    # XDG config directory
│   ├── fish/                   # Fish shell configs
│   ├── lazygit/                # Git TUI configuration
│   ├── nix/                    # Nix package manager configs
│   ├── nvim/                   # Neovim IDE configuration
│   ├── starship.toml           # Cross-shell prompt
│   ├── zellij/                 # Terminal workspace config
│   └── zsh/                    # Zsh configuration
├── .git/                       # Git version control
├── .scripts/                   # Custom utility scripts
│   ├── ide                     # IDE launcher
│   ├── replace_latex          # Text processing script
│   └── workshop                # Development setup helper
├── .tmux.conf                  # Tmux configuration
├── .zshrc                      # Zsh entrypoint
├── flake.*                     # Nix flake configurations
├── LICENSE                     # MIT License
├── README.*                    # Documentation
└── setup.sh                    # Linux bootstrap script
```

## 🛠️ Featured Tools

### Terminal Environment

| Category        | Tools                            |
| --------------- | -------------------------------- |
| **Shell**       | Zsh (zinit plugin manager), Fish |
| **Multiplexer** | Tmux, Zellij                     |
| **Prompt**      | Starship                         |

### Core Utilities

| Tool     | Description                                  |
| -------- | -------------------------------------------- |
| `eza`    | Modern `ls` replacement with git integration |
| `bat`    | Syntax-highlighting `cat`                    |
| `fzf`    | Fuzzy finder                                 |
| `zoxide` | Smart directory jumper                       |
| `delta`  | Git diff viewer                              |

### Development Essentials

| Tool           | Highlights                                |
| -------------- | ----------------------------------------- |
| Neovim         | Lazy.nvim plugin manager, LSP zero-config |
| Lazygit        | Keyboard-driven Git interface             |
| Miniconda      | Python environment management             |
| Rust Toolchain | Rustup + essential cargo packages         |

## 🔧 Installation Details

### Linux Environment Setup

The installation script performs:

1. **Base System Setup**

   - Install system dependencies
   - Setup Miniconda environments
   - Configure Rust toolchain

2. **Shell Configuration**

   - Zsh with zinit plugin manager
   - Pre-configured Powerlevel10k theme
   - Syntax highlighting & auto-suggestions

3. **Developer Tools**
   - Neovim (NvChad-based config)
   - Tmux with resurrect/continuum
   - Lazygit with custom keybinds

## 🎨 Customization Guide

### Modify Configurations

1. Edit files in `~/.config/`:

   - Neovim: `nvim/lua/custom/`
   - Shells: `zsh/.zshrc` or `fish/config.fish`
   - Theme: `.config/starship.toml`

2. Add new tools:

```bash
# 1. Add package to setup.sh
# 2. Create config in .config/
# 3. Update documentation
```

### Nix Flake Usage

For reproducible environments:

```bash
nix develop  # Enter dev shell
nix run .#neovim  # Run specific package
```

## 🤝 Contributing

PRs and issues are welcome! Please follow these steps:

1. Fork the repository
2. Create feature branch (`git checkout -b feat/amazing-feature`)
3. Commit changes with descriptive messages
4. Push to branch
5. Open Pull Request

## 📜 License

Distributed under MIT License. See `LICENSE` for details.

## 🙏 Acknowledgments

- [LazyVim](https://www.lazyvim.org/) for Neovim configuration base
- All open-source tool maintainers
