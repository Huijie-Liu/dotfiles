# Dotfiles (Linux)

One-command setup for a new Linux machine:

## Quick Start

```bash
# Outside China — GitHub direct
curl -fsSL https://raw.githubusercontent.com/Huijie-Liu/dotfiles/linux/bootstrap.sh | bash

# Inside China — jsDelivr CDN
curl -fsSL https://cdn.jsdelivr.net/gh/Huijie-Liu/dotfiles@linux/bootstrap.sh | bash -s -- --china
```

This single command:

- Installs base packages via **apt** (fish, zsh, neovim, tmux, fzf, eza, zoxide, ripgrep, fd, bat)
- Installs **fish** and sets it as the default shell
- Configures **zsh** to read from `~/.config/zsh` (writes `~/.zshenv`)
- Symlinks all configs into `~/.config/` (existing files backed up as `*.bak.*`)

> **China notes**: Auto-detects network. Git clone falls back to ghproxy. Use `--china` to skip detection.

### Options

| Flag | Description |
|------|-------------|
| `... \| bash -s -- --china` | Force China mirrors |
| `... \| bash -s -- --dotfiles-only` | Only symlink configs |

### Already cloned?

```bash
cd ~/.dotfiles
./bootstrap.sh                 # Full setup
./bootstrap.sh --dotfiles-only # Just re-link configs
```

## What's Included

### Core Tools

- **Shells**: Zsh, Fish with Starship prompt
- **Multiplexers**: Tmux, Zellij
- **Editor**: Neovim with LazyVim
- **File manager**: Yazi

### CLI Productivity

- `fzf`, `bat`, `eza`, `zoxide`
- `lazygit`, `git-delta`
- `ripgrep`, `fd`

## Customization

- **Configs**: Edit files under `~/.dotfiles/.config/` — symlinks in `~/.config/` follow automatically
- **Secrets**: Create `~/.config/fish/conf.d/secrets.fish` for API keys (gitignored)

## License

MIT. See [LICENSE](LICENSE) for details.
