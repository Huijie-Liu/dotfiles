# Personal Dotfiles 🚀

新电脑？一行命令搞定全部配置：

## Quick Start

```bash
# 国外用户 — GitHub 直连
curl -fsSL https://raw.githubusercontent.com/Huijie-Liu/dotfiles/macos/bootstrap.sh | bash

# 国内用户 — jsDelivr CDN（推荐）
curl -fsSL https://cdn.jsdelivr.net/gh/Huijie-Liu/dotfiles@macos/bootstrap.sh | bash -s -- --china
```

这一条命令会自动完成：
- 安装 **Xcode Command Line Tools**
- 安装 **Homebrew**（国内自动走 USTC 镜像）
- 安装 Brewfile 中定义的所有软件包
- 安装 **fish** 并设为默认 shell
- 配置 **zsh** 读取 `~/.config/zsh`（写入 `~/.zshenv`）
- 将配置文件符号链接到 `~/.config/`（已有文件备份为 `*.bak.*`）
- 设置 macOS 偏好（键盘速度、Dock 自动隐藏等）

> **国内网络说明**：脚本会自动检测网络环境。如果 GitHub 直连失败，自动走 ghproxy 镜像克隆仓库；Homebrew 也会自动切到 USTC 镜像。`--china` 参数可强制跳过检测直接使用国内镜像。

### 可选参数

| 命令 | 说明 |
|------|------|
| `... \| bash -s -- --china` | 强制使用国内镜像 |
| `... \| bash -s -- --dotfiles-only` | 只链接配置，不装软件 |
| `... \| bash -s -- --skip-brew` | 跳过 brew 包安装 |

### 如果已经克隆了仓库

```bash
cd ~/.dotfiles
./bootstrap.sh                     # 完整安装
./bootstrap.sh --dotfiles-only     # 只重新链接配置
```

## Bootstrap 做了什么

- 安装 Xcode CLI tools、Homebrew、Brewfile 软件包
- 安装 fish shell 并设为默认
- 写入 `~/.zshenv` 让 zsh 读取 `~/.config/zsh` 配置
- 把 `.config/` 下的每个子目录/文件符号链接到 `~/.config/`（已有文件备份为 `*.bak.*`）
- 设置 macOS 偏好（键盘、Dock、Finder 等）

注意事项：

- `tmux` 会读取 `~/.config/tmux/tmux.conf`
- `conda` 会读取 `~/.config/conda/condarc`
- 重启终端后 fish 生效，zsh 也能正确加载 dotfiles 中的配置

## What's Included

### Core Tools

- **Shells**: Zsh, Fish with modern prompts (Starship)
- **Terminals**: Alacritty, Wezterm, Ghostty
- **Multiplexers**: Tmux, Zellij
- **Editor**: Neovim with LazyVim

### CLI Productivity

- `fzf`, `bat`, `eza`, `zoxide`, `atuin`
- `lazygit`, `git-delta` for Git workflow
- `btop`, `dust`, `fd`, `ripgrep`

### macOS Enhancements

- **Aerospace**: Tiling window manager
- **SKHD**: Hotkey daemon
- **Sketchybar**: Custom menu bar
- **Karabiner**: Keyboard customization

## Customization

- **Configurations**: Edit `~/.dotfiles/.config/` 下的文件，`~/.config/` 中的符号链接会自动指向它们
- **Add Tools**: Update `Brewfile` and run `brew bundle --file Brewfile`
- **Themes**: Modify `starship.toml` and terminal color schemes
- **Package Management**: Use `brew bundle dump --force` to update Brewfile

## License

Distributed under MIT License. See [LICENSE](LICENSE) for details.
