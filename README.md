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
- Installs CLI tools: `neovim`, `fish`, `ghostty`, `tmux`, `zellij`, `zoxide`, `ripgrep`, `fd`, `jq`, `node`, `lazygit`
- Sets **fish** as the default shell; writes `~/.zshenv` so zsh reads `~/.config/zsh`
- Symlinks all configs into `~/.config/` (existing files backed up as `*.bak.*`)
- Applies macOS preferences (key repeat, Dock auto-hide, etc.)

> **China notes**: The script auto-detects network environment. GitHub clone falls back to ghproxy; Homebrew falls back to USTC mirrors. Use `--china` to skip detection and force mirrors.

### Options

| Flag | Description |
|------|-------------|
| `... \| bash -s -- --china` | Force China mirrors |
| `... \| bash -s -- --dotfiles-only` | Only symlink configs, skip all installs |

Combine as needed: `bash -s -- --china --dotfiles-only`

### Already cloned?

```bash
cd ~/.dotfiles
./bootstrap.sh                     # Full setup
./bootstrap.sh --dotfiles-only     # Just re-link configs
```

## What's Included

- **Shell**: fish (zsh fallback via `ZDOTDIR`), no plugin manager — plain abbr + zoxide
- **Terminal**: Ghostty (config + shaders)
- **Multiplexers**: tmux, Zellij
- **Editor**: Neovim — custom minimal config on lazy.nvim: native `vim.lsp` (no lspconfig), blink.cmp, snacks.nvim, gitsigns, conform, mini.\*, oil
- **Editor**: Zed settings
- **Git**: shared git config (`zdiff3`, histogram diff, rerere, rebase autoStash)

## Customization

- **Configs**: Edit files under `~/.dotfiles/.config/` — symlinks in `~/.config/` follow automatically
- **Secrets**: put API keys in `~/.config/fish/conf.d/secrets.fish` (gitignored)

## License

MIT. See [LICENSE](LICENSE) for details.
