#!/usr/bin/env bash
set -e

# 彩色输出
info()    { echo -e "\033[1;34m[INFO]\033[0m    $*"; }
warn()    { echo -e "\033[1;33m[WARN]\033[0m    $*"; }
success() { echo -e "\033[1;32m[SUCCESS]\033[0m $*"; }

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_SUFFIX=".bak"
CONFIG_FILES=(.zshrc .tmux.conf .condarc)

# 1. Homebrew 安装（自动判断镜像）
install_homebrew() {
    if ! command -v brew >/dev/null 2>&1; then
        info "Homebrew 未安装，正在安装..."
        if curl -s --connect-timeout 2 https://mirrors.ustc.edu.cn >/dev/null; then
            info "检测到中国大陆网络，使用 USTC 镜像安装 Homebrew"
            export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
            export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
            export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
            export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
            /bin/bash -c "$(curl -fsSL https://github.com/Homebrew/install/raw/HEAD/install.sh)"
        else
            info "使用官方源安装 Homebrew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
    else
        info "Homebrew 已安装，跳过。"
    fi
}

# 2. Brewfile 安装
install_brewfile() {
    info "使用 Brewfile 安装所有依赖..."
    brew bundle install --file="$REPO_DIR/Brewfile"
}

# 3. 软链主目录配置文件
link_file() {
    src="$REPO_DIR/$1"
    dest="$HOME/$1"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        warn "$dest 已存在，备份为 $dest$BACKUP_SUFFIX"
        mv "$dest" "$dest$BACKUP_SUFFIX"
    fi
    ln -sf "$src" "$dest"
    info "软链 $src -> $dest"
}

# 4. 自动遍历 .config 下所有文件和目录进行软链
link_config_all() {
    mkdir -p "$HOME/.config"
    for item in "$REPO_DIR/.config"/*; do
        name="$(basename "$item")"
        [ "$name" = ".DS_Store" ] && continue
        src="$item"
        dest="$HOME/.config/$name"
        if [ -e "$dest" ] && [ ! -L "$dest" ]; then
            warn "$dest 已存在，备份为 $dest$BACKUP_SUFFIX"
            mv "$dest" "$dest$BACKUP_SUFFIX"
        fi
        ln -sf "$src" "$dest"
        info "软链 $src -> $dest"
    done
}

main() {
    install_homebrew
    install_brewfile
    for f in "${CONFIG_FILES[@]}"; do link_file "$f"; done
    link_config_all
    success "Dotfiles 环境部署完成！"
}

main "$@" 