#!/bin/bash

# 函数：检查命令是否成功执行
check_command() {
    if [ $? -ne 0 ]; then
        echo -e "\033[31m错误: $1\033[0m"  # 红色错误提示
        return 1
    fi
    return 0
}

# 更新系统
echo "🛠️ 更新系统..."
sudo apt update && sudo apt upgrade -y
check_command "更新系统失败" || exit 1

# 安装工具列表
declare -a tools=("zsh" "fish" "neovim" "tmux" "fonts-noto-color-emoji" "fd-find" "bat" "build-essential")

# 安装工具
for tool in "${tools[@]}"; do
    if ! dpkg -l | grep -q "$tool"; then
        echo "🔧 安装 $tool..."
        sudo apt install -y "$tool"
        check_command "安装 $tool 失败" || continue
    else
        echo "✅ $tool 已安装，跳过..."
    fi
done

# 安装 fzf
if [ ! -d "$HOME/.fzf" ]; then
    echo "🔍 克隆 fzf 仓库..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    check_command "克隆 fzf 失败" || exit 1

    echo "🔧 安装 fzf..."
    ~/.fzf/install
    check_command "安装 fzf 失败" || exit 1
else
    echo "✅ fzf 已安装，跳过..."
fi

# 安装 tpm
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "🔍 克隆 tpm 仓库..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    check_command "克隆 tpm 失败" || exit 1
else
    echo "✅ tpm 已安装，跳过..."
fi

# 安装 starship
if ! command -v starship &> /dev/null; then
    echo "✨ 安装 starship..."
    curl -sS https://starship.rs/install.sh | sh
    check_command "安装 starship 失败" || exit 1
else
    echo "✅ starship 已安装，跳过..."
fi

# 安装 eza
if ! command -v eza &> /dev/null; then
    echo "📥 下载 eza..."
    wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz

    echo "🔒 设置 eza 权限..."
    sudo chmod +x eza
    sudo chown root:root eza
    sudo mv eza /usr/local/bin/eza
    check_command "安装 eza 失败" || exit 1
else
    echo "✅ eza 已安装，跳过..."
fi

# 安装 Miniconda
if [ ! -d "$HOME/.miniconda" ]; then
    echo "📦 下载 Miniconda..."
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
    check_command "下载 Miniconda 失败" || exit 1

    echo "🔧 安装 Miniconda..."
    bash miniconda.sh -b -p $HOME/.miniconda
    check_command "安装 Miniconda 失败" || exit 1

    rm miniconda.sh

    # 初始化 conda
    echo "🚀 初始化 Miniconda..."
    source "$HOME/.miniconda/etc/profile.d/conda.sh"
    conda init
    check_command "初始化 Miniconda 失败" || exit 1

    echo 'export PATH="$HOME/.miniconda/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
else
    echo "✅ Miniconda 已安装，跳过..."
fi

# 安装 lazygit
if ! command -v lazygit &> /dev/null; then
    echo "🔍 尝试通过 conda 安装 lazygit..."
    conda install -c conda-forge lazygit
    if [ $? -eq 0 ]; then
        echo "✅ 通过 conda 安装 lazygit 成功！"
    else
        echo "❌ conda 安装 lazygit 失败，尝试从 GitHub 下载..."

        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        echo "📥 下载 lazygit ${LAZYGIT_VERSION}..."
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

        echo "📦 解压 lazygit..."
        tar xf lazygit.tar.gz lazygit

        echo "🔧 安装 lazygit..."
        sudo install lazygit /usr/local/bin
        check_command "安装 lazygit 失败" || exit 1

        echo "🗑️ 清理临时文件..."
        rm lazygit.tar.gz lazygit
    fi
else
    echo "✅ lazygit 已安装，跳过..."
fi

# 创建软链接的路径
HOME_DIR="$HOME"
NVIM_CONFIG_DIR="$HOME_DIR/.config/nvim"
TMUX_CONFIG_FILE="$HOME_DIR/.tmux.conf"
FISH_CONFIG_DIR="$HOME_DIR/.config/fish"
ZSH_CONFIG_FILE="$HOME_DIR/.zshrc"

# 创建软链接的函数
create_symlink() {
    local target=$1
    local link_name=$2

    if [ ! -e "$link_name" ]; then
        ln -sf "$target" "$link_name"
        echo "🔗 $link_name 软链接已创建"
    else
        echo "✅ $link_name 配置文件已存在，跳过..."
    fi
}

# 创建配置目录
mkdir -p "$NVIM_CONFIG_DIR" "$FISH_CONFIG_DIR"

# 创建 fd 的软链接
if [ ! -d ~/.local/bin ]; then
    mkdir -p ~/.local/bin
    echo "📁 创建文件夹 ~/.local/bin"
fi

if [ ! -e ~/.local/bin/fd ]; then
    ln -s $(which fdfind) ~/.local/bin/fd
    echo "🔗 fd 软链接已创建"
else
    echo "✅ fd 软链接已存在，跳过..."
fi

# 创建 nvim 的配置文件软链接
create_symlink "$HOME_DIR/.dotfiles/.config/nvim" "$NVIM_CONFIG_DIR"

# 创建 tmux 的配置文件软链接
create_symlink "$HOME_DIR/.dotfiles/.config/.tmux.conf" "$TMUX_CONFIG_FILE"

# 创建 fish 的配置文件软链接
create_symlink "$HOME_DIR/.dotfiles/.config/fish/config.fish" "$FISH_CONFIG_DIR/config.fish"

# 创建 zsh 的配置文件软链接
create_symlink "$HOME_DIR/.dotfiles/.zshrc" "$ZSH_CONFIG_FILE"

echo "🎉 所有工具安装和配置完成！"
