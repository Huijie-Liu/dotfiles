# 开发环境配置 🚀

这是我的个人开发环境配置文件集合，包含了终端、Shell、编辑器等各种工具的配置。

**注意：** 这些配置主要用于参考。建议根据个人需求选择性使用。请谨慎操作！

## 快速开始

### 克隆仓库

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 自动安装

根据你的操作系统选择对应的安装脚本：

```bash
# macOS
bash setup_macos.sh

# Linux
bash setup_linux.sh
```

## 功能特性

- 支持 macOS 和 Linux 系统
- 自动安装和配置常用开发工具
- 模块化的配置文件组织
- 统一的主题风格

## 目录结构

```
.
├── README.md                    # 项目文档
├── setup_linux.sh              # Linux 环境配置脚本  
├── setup_macos.sh              # macOS 环境配置脚本
├── .scripts/                    # 实用脚本目录
├── .config/                    # 配置文件目录
│   ├── alacritty/             # Alacritty 终端配置
│   ├── fish/                  # Fish shell 配置
│   ├── nvim/                  # Neovim 配置
│   ├── sketchybar/           # Sketchybar 配置(macOS)
│   ├── starship/             # Starship 主题配置
│   ├── yabai/                # Yabai 窗口管理配置(macOS)
│   ├── skhd/                 # SKHD 快捷键配置(macOS)
│   └── zsh/                  # Zsh 配置
└── .gitignore                 # Git 忽略文件
```

## 包含的工具

### 终端工具

- **Shell**: 
  - Zsh (带 Oh My Zsh)
  - Fish Shell
- **终端模拟器**: 
  - Alacritty
  - iTerm2 (仅 macOS)
- **终端复用器**: 
  - Tmux

### 命令行工具

- **基础工具**:
  - fzf - 模糊查找
  - fd - 更好的 find
  - bat - 更好的 cat
  - eza - 更好的 ls
  - delta - 更好的 git diff
  - zoxide - 更智能的 cd
  - starship - 跨平台 Shell 提示符

- **开发工具**:
  - lazygit - Git TUI 界面
  - neovim - 现代化的 vim 编辑器
  - tmux - 终端复用器

### macOS 专属

- **窗口管理**:
  - Yabai - 平铺式窗口管理器
  - SKHD - 快捷键守护程序
  - Sketchybar - 自定义菜单栏

- **效率工具**:
  - Raycast - 启动器
  - BetterTouchTool - 触控板增强
  - Bartender - 菜单栏管理

## 安装说明

### Linux 环境

Linux 安装脚本会自动配置：

1. 基础开发环境
   - Miniconda
   - Rust 工具链
   - 常用命令行工具

2. Shell 环境
   - Zsh 配置
   - Shell 插件

3. 开发工具
   - Neovim
   - Tmux
   - lazygit

### macOS 环境

macOS 安装脚本额外包含：

1. GUI 应用安装
   - iTerm2
   - Alacritty
   - Raycast 等

2. 窗口管理
   - Yabai
   - SKHD
   - Sketchybar

3. Shell 环境
   - Fish Shell 配置
   - Starship 主题

## 自定义

1. 修改配置文件
   - 编辑 `~/.config` 下对应的配置文件
   - 根据需要调整 Shell 配置

2. 添加新工具
   - 编辑安装脚本添加新的软件包
   - 在 `.config` 目录添加配置文件

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

## 致谢

感谢所有开源工具的作者们！
