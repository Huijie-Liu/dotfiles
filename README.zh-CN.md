# 开发环境配置 🚀

本仓库包含为 macOS 系统定制的个人开发环境配置，涵盖终端设置、Shell 定制、编辑器配置及效率工具集成。

**注意：** 本配置根据个人工作流定制，请按需选择使用！

## 快速开始

### 克隆仓库
```bash
git clone --branch macos https://github.com/Huijie-Liu/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 自动安装
```bash
# macOS
bash setup.sh
```

## 功能特性

- **macOS 优化**：专为 Apple Silicon 设备优化
- **一键式安装**：自动化部署开发工具链
- **模块化设计**：配置结构清晰易扩展
- **统一主题**：跨工具视觉风格一致

## 目录结构

```
.
├── README.md                   # 主文档
├── setup.sh                    # macOS 自动化脚本
├── .scripts/                   # 自定义工具脚本
├── .config/                    # 应用配置目录
│   ├── aerospace/              # 窗口管理器配置
│   ├── alacritty/              # Alacritty 终端配置
│   ├── fish/                   # Fish Shell 配置
│   ├── ghostty/                # Ghostty 终端配置
│   ├── nvim/                   # Neovim IDE 配置
│   ├── sketchybar/             # macOS 状态栏配置
│   ├── skhd/                   # 快捷键守护进程配置
│   ├── starship.toml           # Shell 提示符配置
│   ├── wezterm/                # Wezterm 终端配置
│   ├── yabai/                  # 平铺窗口管理器配置
│   ├── zellij/                 # 终端复用器配置
│   └── zsh/                    # Zsh 配置
├── .tmux.conf                  # Tmux 配置文件
├── .zshrc                      # Zsh 配置文件
└── LICENSE                     # MIT 许可证
```

## 核心组件

### 终端生态

- **Shell 环境**：
  - Zsh + Oh My Zsh & Powerlevel10k
  - Fish + Tide 提示符
- **终端模拟器**：
  - Alacritty
  - Wezterm
  - iTerm2
- **多路复用器**：
  - Tmux
  - Zellij

### 命令行工具链

- **效率工具**：
  - `fzf` (模糊搜索)
  - `bat` (语法高亮)
  - `eza` (现代化 ls)
  - `zoxide` (智能路径跳转)
- **Git 增强**：
  - `lazygit` (终端界面)
  - `delta` (差异对比工具)

### macOS 专属组件

- **窗口管理**：
  - Yabai (平铺窗口管理器)
  - SKHD (快捷键守护进程)
  - Sketchybar (自定义菜单栏)
- **系统增强**：
  - Raycast (快速启动器)
  - BetterTouchTool (输入定制)
  - Bartender (菜单栏管理)

## 安装指南

### macOS 环境

安装脚本 (`setup.sh`) 自动完成：

1. **基础组件**：
   - Homebrew 包管理器
   - 核心开发工具链

2. **图形应用**：
   - iTerm2/Alacritty 终端
   - 效率工具套件

3. **Shell 环境**：
   - Zsh/Fish 配置
   - Starship 跨平台提示符

4. **窗口管理**：
   - Yabai/SKHD/Sketchybar 组合
   - 预配置快捷键绑定

## 定制指南

1. **修改配置**：
   - 编辑 `~/.config/` 下文件
   - 调整 Shell 配置 (`~/.zshrc`, `~/.config/fish`)

2. **添加工具**：
   - 扩展 `setup.sh` 安装脚本
   - 创建对应配置目录

3. **主题调整**：
   - 修改 `starship.toml` 提示符配置
   - 调整终端配色方案 (位于 `alacritty/` 或 `wezterm/`)

## 贡献说明

欢迎贡献！请遵循：

1. 提交 issue 讨论
2. 保持配置模块化
3. 维护多版本兼容性

## 许可证

MIT 许可证，详见 [LICENSE](LICENSE) 文件。

---

**致谢**：本配置基于众多开源项目构建，特别感谢所有工具维护者和社区贡献者。