#!/bin/bash
# macOS 环境自动化配置脚本
# 功能：安装基础工具、开发环境配置和系统美化

# ========================
# 常量与配置
# ========================
readonly RED='\033[31m'
readonly GREEN='\033[32m'
readonly BLUE='\033[34m'
readonly YELLOW='\033[33m'
readonly RESET='\033[0m'

# 应用列表配置
readonly GUI_APPS=(
    iterm2 wezterm alacritty warp
    aerospace bartender bettertouchtool
    raycast 1password keka spotify
)

readonly CLI_TOOLS=(
    zsh fish git fzf fd bat eza
    ripgrep delta zoxide tldr thefuck
    lazygit starship
)

# 路径配置
readonly DOTFILES_DIR="${HOME}/.dotfiles"
readonly CONFIG_DIR="${HOME}/.config"
readonly BIN_DIR="${HOME}/.local/bin"

# ========================
# 功能函数
# ========================
print_header() {
    local message="$1"
    echo -e "${GREEN}\n${message}${RESET}"
    echo "==============================="
}

print_section() {
    echo -e "${BLUE}\n🔧 $1${RESET}"
}

print_status() {
    case $1 in
        success) echo -e "${GREEN}[✔] $2${RESET}" ;;
        info)    echo -e "${BLUE}[ℹ] $2${RESET}" ;;
        warn)    echo -e "${YELLOW}[⚠] $2${RESET}" ;;
        error)   echo -e "${RED}[✖] $2${RESET}" ;;
    esac
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

user_confirmation() {
    local prompt_msg="$1"
    local default_choice="${2:-y}"
    
    while true; do
        read -rp "${prompt_msg} [Y/n] " response
        response=${response:-${default_choice}}
        # 修改后的兼容性处理 ↓
        case "$(echo "$response" | tr '[:upper:]' '[:lower:]')" in
            y|yes) return 0 ;;
            n|no)  return 1 ;;
            *)     echo "请输入 y 或 n"
        esac
    done
}

# ========================
# 核心功能
# ========================
install_homebrew() {
    print_section "检查 Homebrew 安装"
    
    if command_exists brew; then
        print_status success "Homebrew 已安装"
        return
    fi

    print_status info "开始安装 Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
        print_status error "Homebrew 安装失败"
        exit 1
    }
    print_status success "Homebrew 安装成功"
}

install_package() {
    local package="$1"
    local is_cask="${2:-false}"
    
    if command_exists "${package}"; then
        print_status success "${package} 已存在"
        return
    fi

    print_status info "正在安装 ${package}..."
    if [[ "${is_cask}" == true ]]; then
        brew install --cask "${package}"
    else
        brew install "${package}"
    fi || {
        print_status error "${package} 安装失败"
        return 1
    }
    print_status success "${package} 安装完成"
}

configure_shell() {
    local shell_name="$1"
    
    case "${shell_name}" in
        zsh)
            print_section "配置 ZSH 环境"
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            git clone https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k"
            ;;
        fish)
            print_section "配置 Fish 环境"
            curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
            fisher install IlanCosman/tide@v5 jorgebucaran/fzf.fish jorgebucaran/autopair.fish jhillyerd/plugin-git
            ;;
    esac
}

create_symlinks() {
    print_section "创建配置文件链接"
    
    # 处理 .config 目录
    if [[ -d "${DOTFILES_DIR}/.config" ]]; then
        for config_item in "${DOTFILES_DIR}"/.config/*; do
            local item_name=$(basename "${config_item}")
            link_file "${config_item}" "${CONFIG_DIR}/${item_name}"
        done
    fi

    # 核心配置文件
    link_file "${DOTFILES_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
    link_file "${DOTFILES_DIR}/.zshrc" "${HOME}/.zshrc"
    link_file "${DOTFILES_DIR}/.condarc" "${HOME}/.condarc"

    # 脚本文件
    mkdir -p "${BIN_DIR}"
    for script in "${DOTFILES_DIR}"/.scripts/*; do
        [[ -f "${script}" ]] && link_file "${script}" "${BIN_DIR}/$(basename "${script}")"
    done
}

link_file() {
    local source_path="$1"
    local target_path="$2"
    
    if [[ -L "${target_path}" ]]; then
        print_status success "符号链接已存在: ${target_path}"
        return
    fi

    if [[ -e "${target_path}" ]]; then
        user_confirmation "检测到现有文件 ${target_path}，是否替换？" || return
        rm -rf "${target_path}"
    fi

    ln -sf "${source_path}" "${target_path}" && print_status success "创建链接: ${target_path} → ${source_path}"
}

# ========================
# 主执行流程
# ========================
main() {
    print_header "macOS 环境自动化配置"
    
    # 安装基础工具
    install_homebrew
    
    # GUI 应用安装
    print_section "图形界面应用安装"
    for app in "${GUI_APPS[@]}"; do
        user_confirmation "是否安装 ${app}?" && install_package "${app}" true
    done

    # 命令行工具安装
    print_section "命令行工具安装"
    for tool in "${CLI_TOOLS[@]}"; do
        user_confirmation "是否安装 ${tool}?" && install_package "${tool}"
    done

    # Shell 环境配置
    user_confirmation "是否配置 ZSH 环境?" && configure_shell zsh
    user_confirmation "是否配置 Fish 环境?" && configure_shell fish

    # 创建配置链接
    create_symlinks
    
    print_header "所有配置已完成 🎉"
    echo -e "${GREEN}系统已准备就绪，享受你的开发体验！${RESET}"
}

# 执行主函数
main
