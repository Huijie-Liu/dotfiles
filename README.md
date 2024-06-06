# My Dev Environment Configuration 🚀

**IMPORTANT:** These are primarily meant for inspiration. I wouldn't just blindly use them. Proceed at your own risk!

# MacOS Setup (optional)

Here are some tips to improve your Mac settings for better effectiveness.

## Display Setup

- Accessibility > Display
  - Turn On Reduce Motion
- Desktop & Dock > Mission Control
  - only keep “Displays Have Separate Spaces” turned on

## Keyboard Setup

- change keyboard binging
  - Caps Lock <--> Control

- Key repeating speed up

  ```
  defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
  ```

## Software Setup

- [iTerm 2](https://iterm2.com/) - Replacement for Terminal.
- [Bartender 5](https://www.macbartender.com/) - Superpowered your menu bar.
- [BetterTouchTool](https://folivora.ai/) - BetterTouchTool is a great, feature packed app that allows you to customize various input devices on your Mac.
- [Raycast](https://www.raycast.com/) - A collection of powerful productivity tools all within an extendable launcher. Fast, ergonomic and reliable.
- [1Password](https://1password.com/zh-cn) - Password manager.
- [typora](https://typora.io/) - Markdown editor.

# Terminal Setup

My personal favorite shells: zsh & fish. With the starship theme.

## Zsh Setup

Zsh is a shell designed for interactive use, although it is also a powerful scripting language.

### Setup Requires

- [homebrew](https://docs.brew.sh/Installation) - package management
- [git](https://git-scm.com/) - version control system
- [Nerd Font](https://www.nerdfonts.com/) - great for showing icons in the termina
- [powerlevel10k](https://github.com/romkatv/powerlevel10k) or [starship](https://starship.rs/) - zsh theme
- CLI tools
  - [fzf](https://github.com/junegunn/fzf) - command line fuzzy finder
  - [fd](https://github.com/sharkdp/fd) - better find
  - [fzf-git](https://github.com/junegunn/fzf-git.sh) - look for git related things with fzf
  - [bat](https://github.com/sharkdp/bat) - better cat
  - [eza](https://github.com/eza-community/eza) - better ls
  - [delta](https://github.com/dandavison/delta) - better git diff
  - [zoxide](https://github.com/ajeetdsouza/zoxide) - better cd

### Relevant Files

- [.zshrc](.zshrc) - Zsh Shell Configuration

## Fish Setup

Fish is a smart and user-friendly command line shell for Linux, macOS, and the rest of the family.

### Plugins

- jorgebucaran/fisher - fish plugin management
- patrickf1/fzf.fish - fzf config for fish
- jorgebucaran/autopair.fish - autopair ()[]''{}...
- jhillyerd/plugin-git - git shortcuts
- IlanCosman/tide - fish theme

### Setup Requires

- [fisher](https://github.com/jorgebucaran/fisher) - fish plugin management
- [tide](https://github.com/IlanCosman/tide) - fish shell theme
- CLI tools
  - [fzf](https://github.com/junegunn/fzf) - command line fuzzy finder
  - [fd](https://github.com/sharkdp/fd) - better find
  - [bat](https://github.com/sharkdp/bat) - better cat
  - [eza](https://github.com/eza-community/eza) - better ls
  - [zoxide](https://github.com/ajeetdsouza/zoxide) - better cd

### Relevant Files

- [.config/fish/config.fish](.config/fish/config.fish) - Fish Shell Configuration

## Starship Setup

The minimal, blazing-fast, and infinitely customizable prompt for any shell!

- **Fast:** it's fast – *really really* fast! 🚀
- **Customizable:** configure every aspect of your prompt.
- **Universal:** works on any shell, on any operating system.
- **Intelligent:** shows relevant information at a glance.
- **Feature rich:** support for all your favorite tools.
- **Easy:** quick to install – start using it in minutes.

### Setup Requires

- starship

  ```bash
  curl -sS https://starship.rs/install.sh | sh
  ```

  or

  ```bash
  brew install starship
  ```

### Relevant Files

- [.config/starship.toml](.config/starship.toml) - Starship theme configuration

## CLI Tools Setup

Amazing CLI tools you won't be able to live without!

- [brew](https://brew.sh/) - package manager for macOS (or Linux)

  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

- [fzf](https://github.com/junegunn/fzf) - command line fuzzy finder

  ```bash
  brew install fzf
  ```

- [fd](https://github.com/sharkdp/fd) - better find

  ```bash
  brew install fd
  ```

- [bat](https://github.com/sharkdp/bat) - better cat

  ```bash
  brew install bat
  ```

- [eza](https://github.com/eza-community/eza) - better ls

  ```bash
  brew install eza
  ```

- [thefuck](https://github.com/nvbn/thefuck) - auto correct mistyped commands

  ```bash
  brew install thefuck
  ```

- [zoxide](https://github.com/ajeetdsouza/zoxide) - better cd

  ```bash
  brew install zoxide
  ```

- [lazygit](https://github.com/jesseduffield/lazygit) or [tig](https://github.com/jonas/tig) - TLI for git

  ```bash
  brew install lazygit
  ```

- [tldr](https://github.com/tldr-pages/tldr) - user friendly man page

  ```
  brew install tldr
  ```

# Yabai Tiling Window Manager Setup (macOS)

Yabai is a window management utility that is designed to work as an extension to the built-in window manager of macOS.

## Setup Requires

- yabai - tiling window manager

  ```bash
  brew install koekeishiya/formulae/yabai
  ```

- skhd - keyboard shortcuts manager

  ```bash
  brew install koekeishiya/formulae/skhd
  ```

## Relevant Files

- [.config/yabai/yabairc](.config/yabai/yabairc)
- [.config/skhd/skhdrc](.config/skhd/skhdrc)

# Sketchybar Custom Menu Bar Setup (macOS)

This bar project aims to create a highly flexible, customizable, fast and powerful status bar replacement for people that like playing with shell scripts.

## Setup Requires

- sketchybar: `brew tap FelixKratz/formulae` and `brew install sketchybar`

- jq (json command line processor): `brew install jq`

- SF Pro Font: `brew tap homebrew/cask-fonts` and `brew install font-sf-pro`

- SF Symbols: `brew install --cask sf-symbols`:

- Sketchybar App Font:

  ```bash
  curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.16/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
  ```

-  [SbarLua](https://github.com/FelixKratz/SbarLua) - The present config for sketchybar is done entirely in lua (and some C), using [SbarLua](https://github.com/FelixKratz/SbarLua).

  ```
  git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/
  ```

## Relevant Files

- [.config/sketchybar](.config/sketchybar)

# Tmux Setup

Tmux is a terminal multiplexer. It lets you switch easily between several programs in one terminal, detach them (they keep running in the background) and reattach them to a different terminal.

## Setup Requires

- tpm - tmux plugin manager

  ```bash
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ```

## Relevant Files

- [.tmux.conf](.tmux.conf) - Tmux Configuration File

# Neovim Setup

Hyperextensible Vim-based text editor.

## Setup Requires

- Neovim >= **0.9.0** (needs to be built with **LuaJIT**)

- Git >= **2.19.0** (for partial clones support)

- [LazyVim](https://www.lazyvim.org/)

- a [Nerd Font](https://www.nerdfonts.com/)(v3.0 or greater) **(optional, but needed to display some icons)**

- [lazygit](https://github.com/jesseduffield/lazygit) (optional)

- a **C** compiler for `nvim-treesitter`. See [here](https://github.com/nvim-treesitter/nvim-treesitter#requirements)

- for telescope.nvim **(optional)**

  - **live grep**: [ripgrep](https://github.com/BurntSushi/ripgrep)
  - **find files**: [fd](https://github.com/sharkdp/fd)
  
- a terminal that support true color and undercurl:

  - [kitty](https://github.com/kovidgoyal/kitty) **(Linux & Macos)**
  - [wezterm](https://github.com/wez/wezterm) **(Linux, Macos & Windows)**
  - [alacritty](https://github.com/alacritty/alacritty) **(Linux, Macos & Windows)**
  - [iterm2](https://iterm2.com/) **(Macos)**

## Relevant Files

- [.config/nvim/](.config/nvim/)

# Quick Setup

I have created a Bash script to automatically install and configure all of my settings.

```bash
git clone https://github.com/Huijie-Liu/dev-environment-files.git
cd dev-environment-files
bash install.sh
```

