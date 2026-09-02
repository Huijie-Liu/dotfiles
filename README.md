# Dotfiles

Personal macOS setup: fish, Ghostty, tmux, Neovim, Zed. Bootstrapped with one command.

## Bootstrap

```bash
# Outside China — GitHub direct
curl -fsSL https://raw.githubusercontent.com/Huijie-Liu/dotfiles/macos/bootstrap.sh | bash

# Inside China — jsDelivr CDN
curl -fsSL https://cdn.jsdelivr.net/gh/Huijie-Liu/dotfiles@macos/bootstrap.sh | bash -s -- --china
```

In order, the script:

1. Clones this repo to `~/.dotfiles` (via ghproxy when in China)
2. Installs **Xcode Command Line Tools**
3. Installs **Homebrew** — USTC mirrors when in China
4. Installs CLI tools: `neovim`, `fish`, `zoxide`, `ripgrep`, `fd`, `jq`, `node`, `lazygit`, `tmux`, `zellij` — plus **Ghostty** (cask) and **tpm**
5. Symlinks everything under `.config/` into `~/.config/` (existing files backed up as `*.bak.*`)
6. Sets **fish** as the default shell (adds it to `/etc/shells`, runs `chsh`) and writes `~/.zshenv` so zsh reads `~/.config/zsh`
7. Applies macOS preferences (key repeat, Dock auto-hide, Finder, screenshots, …)

> **China network**: mirrors are auto-detected — Homebrew uses USTC and the clone goes through ghproxy. Pass `--china` to skip detection and force it.

### Options

| Flag | Effect |
|------|--------|
| `--china` | Force China mirrors (skip auto-detection) |
| `--dotfiles-only` | Only symlink configs; skip every install step |
| `--help` | Show usage |

Flags combine: `bash -s -- --china --dotfiles-only`

### Already cloned?

```bash
cd ~/.dotfiles
./bootstrap.sh                  # full setup (skips what's already installed)
./bootstrap.sh --dotfiles-only  # just (re)link configs
```

## What's Inside

| Area | Setup |
|------|-------|
| Shell | fish — no plugin manager: plain `abbr` + zoxide; zsh fallback via `ZDOTDIR` |
| Terminal | Ghostty (config + shaders) |
| Multiplexers | tmux (tpm), zellij |
| Editor | Neovim — minimal lazy.nvim config: native `vim.lsp` (no lspconfig), blink.cmp, snacks.nvim, gitsigns, conform, mini.\*, oil |
| Editor | Zed |
| Git | shared config: `zdiff3`, histogram diff, rerere, `rebase.autoStash` |

## How Configs Are Managed

- **Per-directory symlinks**: `~/.config/<app>` → `~/.dotfiles/.config/<app>`. Edits are live (no copy step); removing a link is all it takes to opt out.
- **Safe to rerun**: bootstrap only links what's missing, skips already-linked targets, and backs up conflicting files as `*.bak.*` — never overwrites.
- **No config manager**: at this scale (~10 apps) plain symlinks + git cover everything stow/chezmoi would, without extra tooling or a copying step.
- **Machine differences** live on git branches (this branch: `macos`); secrets never leave the machine (`fish/conf.d/secrets.fish` is gitignored).

## Customization

- Edit files under `~/.dotfiles/.config/` — the symlinks in `~/.config/` follow automatically
- Pull in updates from this repo: `git pull` inside `~/.dotfiles`
- Secrets (API keys, tokens) go in `~/.config/fish/conf.d/secrets.fish` — gitignored, never committed

## License

MIT. See [LICENSE](LICENSE).
