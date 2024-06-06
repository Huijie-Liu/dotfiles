#!/bin/bash

echo "欢迎使用Jay的开发环境配置脚本！🚀"
echo "================================================"

# 获取当前项目的目录
CURRENT_DIR=$(pwd)
echo "请确保已进入项目目录，当前目录为$CURRENT_DIR"

function prompt {
	while true; do
		read -p "$1 [y/n]: " yn
		case $yn in
		[Yy]*) return 0 ;;
		[Nn]*) return 1 ;;
		*) echo "请输入 y 或 n." ;;
		esac
	done
}

function check_and_link {
	if command -v $1 >/dev/null 2>&1; then
		ln -s -f -n $CURRENT_DIR/$2 $HOME/$3
		echo "已创建 $HOME/$3 的软链接"
	else
		echo "$1 未安装，跳过 $HOME/$3 的软链接创建"
	fi
}

echo "开始安装前，请确保已经备份了现有的配置文件。"
echo "================================================"

if prompt "【必要】需要安装 Homebrew 吗?"; then
	echo "安装 Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo "================================================"
fi

if prompt "需要安装 iTerm2(macOS) 吗?"; then
	echo "安装 iTerm2..."
	brew install --cask iterm2
	echo "================================================"
fi

if prompt "需要安装 Bartender(macOS) 吗?"; then
	echo "安装 Bartender..."
	brew install --cask bartender
	echo "================================================"
fi

if prompt "需要安装 BetterTouchTool(macOS) 吗?"; then
	echo "安装 BetterTouchTool..."
	brew install --cask bettertouchtool
	echo "================================================"
fi

if prompt "需要安装 Raycast 吗?"; then
	echo "安装 Raycast..."
	brew install --cask raycast
	echo "================================================"
fi

if prompt "需要安装 1Password 吗?"; then
	echo "安装 1Password..."
	brew install --cask 1password
	echo "================================================"
fi

if prompt "需要安装 Typora 吗?"; then
	echo "安装 Typora..."
	brew install --cask typora
	echo "================================================"
fi

if prompt "需要安装并配置 Zsh 和 Fish 吗?"; then
	echo "安装并配置 Zsh 和 Fish..."
	brew install zsh fish starship
	brew install git fzf fd bat eza delta zoxide lazygit tldr thefuck

	echo "配置 Zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
	echo 'source ~/.zshrc' >>~/.zshrc

	echo "配置 Fish..."
	curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
	fisher install IlanCosman/tide@v5
	fisher install jorgebucaran/fzf.fish
	fisher install jorgebucaran/autopair.fish
	fisher install jhillyerd/plugin-git
	echo "================================================"
fi

if prompt "需要安装并配置 Starship 吗?"; then
	echo "安装并配置 Starship..."
	echo 'eval "$(starship init zsh)"' >>~/.zshrc
	echo 'eval "$(starship init fish)"' >>~/.config/fish/config.fish
	curl -sS https://starship.rs/install.sh | sh
	echo "================================================"
fi

if prompt "需要安装并配置 Yabai(macOS) 和 Skhd(macOS) 吗?"; then
	echo "安装并配置 Yabai 和 Skhd..."
	brew install koekeishiya/formulae/yabai
	brew install koekeishiya/formulae/skhd
	brew services start yabai
	brew services start skhd
	echo "================================================"
fi

if prompt "需要安装并配置 Sketchybar(macOS) 吗?"; then
	echo "安装并配置 Sketchybar..."
	brew tap FelixKratz/formulae
	brew install sketchybar
	brew install jq
	brew tap homebrew/cask-fonts
	brew install --cask font-sf-pro
	brew install --cask sf-symbols
	curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.16/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
	git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/
	echo "================================================"
fi

if prompt "需要安装并配置 Tmux 吗?"; then
	echo "安装并配置 Tmux..."
	brew install tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	echo "================================================"
fi

if prompt "需要安装并配置 Neovim 吗?"; then
	echo "安装并配置 Neovim..."
	brew install neovim
	git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/site/pack/lazy/start/lazy.nvim
	echo "================================================"
fi

# 创建配置目录
mkdir -p ~/.config/{fish,yabai,skhd,sketchybar,nvim}

# 样例配置文件链接
echo "创建样例配置文件链接..."

# 创建 .zshrc 的软链接
check_and_link zsh ".zshrc" ".zshrc"

# 创建 .config/fish/config.fish 的软链接
check_and_link fish ".config/fish/config.fish" ".config/fish/config.fish"

# 创建 .config/starship.toml 的软链接
check_and_link starship ".config/starship/starship-bracketed.toml" ".config/starship.toml"

# 创建 .config/yabai/yabairc 的软链接
check_and_link yabai ".config/yabai/yabairc" ".config/yabai/yabairc"

# 创建 .config/skhd/skhdrc 的软链接
check_and_link skhd ".config/skhd/skhdrc" ".config/skhd/skhdrc"

# 创建 .tmux.conf 的软链接
check_and_link tmux ".tmux.conf" ".tmux.conf"

# 创建 .config/nvim 的软链接
check_and_link nvim ".config/nvim" ".config/nvim"

echo "================================================"
echo "安装完成！请重新启动终端或 source 你的 shell 配置文件。"
echo "================================================"
