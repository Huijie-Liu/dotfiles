# dotfiles

macOS setup: fish, Ghostty, zellij, Neovim, Zed.

```bash
# China
curl -fsSL https://cdn.jsdelivr.net/gh/Huijie-Liu/dotfiles@macos/bootstrap.sh | bash -s -- --china

# elsewhere
curl -fsSL https://raw.githubusercontent.com/Huijie-Liu/dotfiles/macos/bootstrap.sh | bash
```

Flags: `--china` force mirrors · `--dotfiles-only` only link configs. Already cloned? `./bootstrap.sh` (rerunning skips what's done).

Configs are symlinked from `~/.dotfiles/.config/` into `~/.config/` — edit the repo copy, it's live. Conflicts are backed up as `*.bak.*`.

Secrets go in `~/.config/fish/conf.d/secrets.fish` (gitignored).

MIT
