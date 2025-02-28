#!/bin/bash

# 颜色配置
R='\033[31m'; G='\033[32m'
Y='\033[33m'; B='\033[34m'
C='\033[36m'; NC='\033[0m'

# 初始化变量
DOTFILES_DIR="$HOME/.dotfiles"
FAILED=()  # 记录失败组件

# 清屏并显示标题
title() {
    clear
    echo -e "${C}
===============================
✨ Dotfiles 安装助手
===============================
${NC}"
}

# 优雅的进度输出
status() { echo -e "\n${B}==>${NC} ${1}..."; }
success() { echo -e "${G}[✓]${NC} ${1}"; }
failure() { echo -e "${R}[✗]${NC} ${1}"; FAILED+=("${2}"); }

# 安装组件基础函数
install() {
    local name="$1" check_cmd="$2" install_cmd="$3"
    
    status "检查 ${name}"
    if eval "${check_cmd}" >/dev/null 2>&1; then
        success "已安装 ${name}"
        return 0
    fi

    status "安装 ${name}"
    eval "${install_cmd}" >/dev/null 2>&1
    
    if eval "${check_cmd}" >/dev/null 2>&1; then
        success "安装成功 ${name}"
    else
        failure "安装失败 ${name}" "${name}"
        return 1
    fi
}

# 组件列表
declare -A COMPONENTS=(
    [1]="Miniconda:::command -v conda:::
        wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
        bash /tmp/miniconda.sh -b -p \$HOME/.miniconda
        rm /tmp/miniconda.sh
        source \$HOME/.miniconda/etc/profile.d/conda.sh
        conda init"
        
    [2]="lazygit:::command -v lazygit:::conda install -c conda-forge lazygit -y"
    [3]="Neovim:::command -v nvim:::
        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
        tar -xzf nvim-linux64.tar.gz -C \$HOME/.local --strip-components=1
        rm nvim-linux64.tar.gz"
    
    [4]="Rust 工具链:::command -v rustc:::
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source \$HOME/.cargo/env"
    
    [5]="fzf:::command -v fzf:::
        git clone --depth 1 https://github.com/junegunn/fzf.git \$HOME/.fzf
        \$HOME/.fzf/install --all"
    
    [6]="tmux plugin manager:::test -d \$HOME/.tmux/plugins/tpm:::
        git clone --depth 1 https://github.com/tmux-plugins/tpm \$HOME/.tmux/plugins/tpm"
)

# Cargo 包管理
cargo_install() {
    local packages=(zoxide fd-find ripgrep eza starship bat yazi-fm yazi-cli)
    for pkg in "${packages[@]}"; do
        install "cargo-${pkg}" "command -v ${pkg}" "cargo install ${pkg} --locked"
    done
}

# 配置符号链接
link_config() {
    mkdir -p "$HOME/.config" "$HOME/.local/bin"
    
    local links=(
        "$DOTFILES_DIR/.config/*:$HOME/.config"
        "$DOTFILES_DIR/.scripts/*:$HOME/.local/bin"
        "$DOTFILES_DIR/.tmux.conf:$HOME/.tmux.conf"
        "$DOTFILES_DIR/.condarc:$HOME/.condarc"
    )

    for pair in "${links[@]}"; do
        src="${pair%%:*}"
        dest="${pair##*:}"
        ln -sf $src "$dest" 2>/dev/null && success "链接 $src → $dest" || failure "链接失败 $src" "$src"
    done
}

# 主流程
title
echo -e "${Y}欢迎使用开发环境配置向导！\n请选择需要安装的组件：${NC}"

# 显示菜单
for i in "${!COMPONENTS[@]}"; do
    echo -e "${C}  ${i}) ${COMPONENTS[$i]%%::*}${NC}"
done

# 获取选择
read -p $'\n输入序号 (空格分隔/回车全选): ' -a input
selected=("${input[@]}")
[[ ${#selected[@]} -eq 0 ]] && selected=("${!COMPONENTS[@]}")

# 执行安装
title
for choice in "${selected[@]}"; do
    IFS=':::' read name check_cmd install_cmd <<< "${COMPONENTS[$choice]}"
    
    if [[ "$name" == "Cargo 工具链" ]]; then
        install "$name" "$check_cmd" "$install_cmd"
        cargo_install
    else
        install "$name" "$check_cmd" "$install_cmd"
    fi
done

# 配置链接
status "配置符号链接"
link_config

# 最终状态
title
if [[ ${#FAILED[@]} -eq 0 ]]; then
    echo -e "${G}
🎉 所有组件安装成功！
➜ 请重启终端使配置生效${NC}"
else
    echo -e "${R}
⚠️  以下组件安装失败：${NC}"
    for item in "${FAILED[@]}"; do
        echo -e "${Y}  • ${item}${NC}"
    done
fi