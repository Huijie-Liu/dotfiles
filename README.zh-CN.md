# 开发环境配置 🚀

![Shell Integration](https://img.shields.io/badge/Shell-Zsh%20%7C%20Fish-blueviolet)
![Editor](https://img.shields.io/badge/Editor-Neovim-brightgreen)
![Package Manager](https://img.shields.io/badge/Package-Nix-orange)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

本仓库包含我跨平台的开发环境配置，涵盖终端、Shell、编辑器及各类生产力工具，适用于 Linux/macOS 系统开发者。

**免责声明**：这些配置具有个人偏好性，请根据实际需求谨慎使用。

## 🚀 快速开始

### 环境要求

- Git 2.0+
- Bash 4.0+
- curl/wget

### 克隆仓库

```bash
git clone --branch linux https://github.com/Huijie-Liu/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 自动化安装 (Linux)

```bash
bash setup.sh
```

## ✨ 特性

- **跨平台支持**：优化适配 Linux/macOS 双系统
- **现代工具链**：预置开发核心组件
- **模块化设计**：组件可自由启用/禁用
- **统一风格**：全工具链一致主题
- **可复现性**：支持 Nix flake 环境配置

## 📂 目录结构

```text
.
├── .condarc                    # Conda 配置
├── .config/                    # XDG 配置目录
│   ├── fish/                   # Fish Shell 配置
│   ├── lazygit/                # Git 终端界面配置
│   ├── nix/                    # Nix 包管理器配置
│   ├── nvim/                   # Neovim IDE 配置
│   ├── starship.toml           # 跨 Shell 提示符
│   ├── zellij/                 # 终端工作区配置
│   └── zsh/                    # Zsh 配置
├── .git/                       # 版本控制数据
├── .scripts/                   # 实用脚本集
│   ├── ide                     # IDE 启动器
│   ├── replace_latex           # 文本处理脚本
│   └── workshop                # 开发环境助手
├── .tmux.conf                  # Tmux 配置
├── .zshrc                      # Zsh 入口配置
├── flake.*                     # Nix flake 配置
├── LICENSE                     # MIT 许可证
├── README.*                    # 项目文档
└── setup.sh                    # Linux 环境引导脚本
```

## 🛠️ 核心工具

### 终端环境

| 类别         | 工具                       |
| ------------ | -------------------------- |
| **Shell**    | Zsh (zinit 插件管理), Fish |
| **多路复用** | Tmux, Zellij               |
| **提示符**   | Starship                   |

### 核心工具

| 工具     | 描述                        |
| -------- | --------------------------- |
| `eza`    | 增强版 `ls` (支持 git 集成) |
| `bat`    | 语法高亮 `cat`              |
| `fzf`    | 模糊搜索工具                |
| `zoxide` | 智能目录跳转                |
| `delta`  | 增强版 git diff             |

### 开发工具链

| 工具        | 亮点                      |
| ----------- | ------------------------- |
| Neovim      | 基于 Lazy.nvim 的插件系统 |
| Lazygit     | 键盘驱动的 Git 界面       |
| Miniconda   | Python 环境管理           |
| Rust 工具链 | Rustup + 核心 cargo 包    |

## 🔧 安装详情

### Linux 环境配置

安装脚本将自动完成：

1. **基础环境搭建**

   - 系统依赖安装
   - Miniconda 环境配置
   - Rust 工具链设置

2. **Shell 环境配置**

   - Zsh + zinit 插件管理器
   - Powerlevel10k 主题预配置
   - 语法高亮与自动建议

3. **开发工具部署**
   - Neovim (基于 NvChad 配置)
   - Tmux 会话持久化配置
   - Lazygit 自定义快捷键

## 🎨 自定义指南

### 修改配置

1. 编辑 `~/.config/` 下文件：

   - Neovim: `nvim/lua/custom/`
   - Shell: `zsh/.zshrc` 或 `fish/config.fish`
   - 主题: `.config/starship.toml`

2. 添加新工具：

```bash
# 1. 在 setup.sh 中添加安装包
# 2. 在 .config/ 创建对应配置
# 3. 更新文档说明
```

### Nix Flake 使用

创建可复现的开发环境：

```bash
nix develop   # 进入开发环境
nix run .#neovim  # 运行指定工具
```

## 🤝 贡献指南

欢迎提交改进建议！请按以下流程操作：

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feat/新特性`)
3. 提交描述清晰的 commit
4. 推送至分支
5. 发起 Pull Request

## 📜 许可证

本项目采用 MIT 许可证，详见 [LICENSE](LICENSE) 文件。

## 🙏 致谢

- [LazyVim](https://www.lazyvim.org/) Neovim 配置基础
- 所有开源工具维护者
