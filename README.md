# Dotfiles (Windows)

One-command setup for a new Windows machine:

## Quick Start

Open **PowerShell as Administrator** and run:

```powershell
irm https://cdn.jsdelivr.net/gh/Huijie-Liu/dotfiles@windows/setup.ps1 | iex
```

This single command:

- Installs **Scoop** package manager
- Installs core packages (git, fish, neovim, starship, zoxide, fzf, eza, bat, fd, ripgrep, lazygit, wezterm)
- Symlinks all configs into `~\.config\`
- Sets up PowerShell profile to source `~\.dotfiles\.PSprofile.ps1`

### Options

| Flag | Description |
|------|-------------|
| `... \| iex -Args "--dotfiles-only"` | Only symlink configs |

### Already cloned?

```powershell
cd ~\.dotfiles
.\setup.ps1                 # Full setup
.\setup.ps1 -DotfilesOnly   # Just re-link configs
```

## What's Included

### Shells

- **PowerShell**: Starship prompt, PSReadLine, fzf keybindings
- **Fish**: Starship prompt, zoxide, fzf, custom aliases and functions
- **Zsh** (via WSL)

### Tools

| Category | Tools |
|----------|-------|
| **Editor** | Neovim with LazyVim |
| **Terminal** | Wezterm |
| **File Ops** | eza, bat, fd, ripgrep |
| **Navigation** | zoxide, fzf |
| **Git** | lazygit |
| **Prompt** | Starship |

## Customization

- **Configs**: Edit files under `~\.dotfiles\.config\` — symlinks in `~\.config\` follow automatically
- **PowerShell**: Edit `~\.dotfiles\.PSprofile.ps1`
- **Secrets**: Create `~\.config\fish\conf.d\secrets.fish` for API keys (gitignored)

## License

MIT. See [LICENSE](LICENSE) for details.
