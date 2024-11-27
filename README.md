# Development Environment Configuration 🚀

This is my personal development environment configuration collection, including terminal, shell, editor, and various tools configurations.

**Note:** These configurations are mainly for reference. It's recommended to selectively use them based on your personal needs. Please proceed with caution!

## Quick Start

### Clone Repository

```bash
git clone --branch linux https://github.com/Huijie-Liu/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### Automatic Installation

Choose the installation script according to your operating system:

```bash
# Linux
bash setup_linux.sh
```

## Features

- Support for macOS and Linux systems
- Automatic installation and configuration of common development tools
- Modular configuration file organization
- Unified theme style

## Directory Structure

```
.
├── README.md                    # Project documentation
├── setup.sh                     # Linux environment setup script
├── .scripts/                   # Utility scripts directory
├── .config/                    # Configuration files directory
│   ├── fish/                  # Fish shell config
│   ├── nvim/                  # Neovim config
│   ├── starship/             # Starship theme config
│   └── zsh/                  # Zsh config
└── .gitignore                 # Git ignore file
```

## Included Tools

### Terminal Tools

- **Shell**:
  - Zsh (with zinit)
  - Fish Shell
- **Terminal Multiplexer**:
  - Tmux

### Command Line Tools

- **Basic Tools**:

  - fzf - Fuzzy finder
  - fd - Better find
  - bat - Better cat
  - eza - Better ls
  - delta - Better git diff
  - zoxide - Smarter cd
  - starship - Cross-platform shell prompt

- **Development Tools**:
  - lazygit - Git TUI interface
  - neovim - Modern vim editor
  - tmux - Terminal multiplexer

## Installation Guide

### Linux Environment

The Linux installation script will automatically configure:

1. Basic Development Environment

   - Miniconda
   - Rust toolchain
   - Common command line tools

2. Shell Environment

   - Zsh configuration
   - Shell plugins

3. Development Tools
   - Neovim
   - Tmux
   - lazygit

## Customization

1. Modify Configuration Files

   - Edit corresponding config files under `~/.config`
   - Adjust shell configuration as needed

2. Add New Tools
   - Edit installation scripts to add new packages
   - Add configuration files in the `.config` directory

## Contributing

Issues and Pull Requests are welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

Thanks to all the authors of the open source tools!
