# Development Environment Configuration 🚀

This is my personal development environment configuration collection, including terminal, shell, editor, and various tools configurations.

**Note:** These configurations are mainly for reference. It's recommended to selectively use them based on your personal needs. Please proceed with caution!

## Quick Start

### Clone Repository

```bash
git clone --branch windows https://github.com/Huijie-Liu/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### Automatic Installation

Choose the installation script according to your operating system:

```bash
# Windows
. setup.ps1
```

## Features

- Support for windows systems
- Automatic installation and configuration of common development tools
- Modular configuration file organization
- Unified theme style

## Directory Structure

```
.
├── README.md                    # Project documentation
├── .PSprofile.ps1               # powershell env file
├── setup.ps1                    # windows environment setup script
├── .scripts/                   # Utility scripts directory
├── .config/                    # Configuration files directory
│   ├── fish/                  # Fish shell config
│   ├── nvim/                  # Neovim config
│   ├── starship             # Starship theme config
│   ├── wezterm/             # Terminal Emulator
│   └── zsh/                  # Zsh config
└── .gitignore                 # Git ignore file
```

## Included Tools

### Terminal Tools

- **Shell**:
  - PowerShell
  - Zsh (via Windows Subsystem for Linux - WSL)
  - Fish (via Windows Subsystem for Linux - WSL)
- **Terminal Emulator**:
  - Windows Terminal
  - Alacritty
  - WezTerm

### Command Line Tools

- **Basic Tools**:

  - Git
  - curl
  - wget
  - tar
  - 7-Zip (via `7z` CLI)
  - Chocolatey (Windows package manager)

- **Development Tools**:
  - Miniconda (Python environment management)
  - Rust (Rust toolchain via `rustup`)
  - Node.js (via `nvm-windows` or Chocolatey)
  - Neovim (for modern text editing)
  - lazygit (Git TUI)
  - Tmux (via WSL)

### Windows Specific

- **Window Management**:

  - PowerToys (Windows productivity enhancements)
  - FancyZones (window tiling manager via PowerToys)

- **Productivity Tools**:
  - Windows Terminal Cascadia Code (font customization and themes)
  - AutoHotkey (hotkey and scripting automation)
  - Microsoft Power Automate Desktop (workflow automation)

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
