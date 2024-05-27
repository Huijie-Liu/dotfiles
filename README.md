# My Dev Environment Files 🚀

**IMPORTANT:** These are primarily meant for inspiration. I wouldn't just blindly use them. Proceed at your own risk!

# Terminal Setup

My personal favorite shells: zsh & fish. With the starship theme.

## Zsh Setup

✍🏼 Blog Post : [7 Amazing CLI Tools You Won't Be Able To Live Without](https://www.josean.com/posts/7-amazing-cli-tools)

### Setup Requires

- [homebrew](https://docs.brew.sh/Installation) - package management
- git
- [Nerd Font](https://www.nerdfonts.com/) - great for showing icons in the termina
- [powerlevel10k](https://github.com/romkatv/powerlevel10k) or [starship](https://starship.rs/) - zsh theme
- CLI tools
  - [fzf](https://github.com/junegunn/fzf) - command line fuzzy finder
  - [fd](https://github.com/sharkdp/fd) - better find
  - [fzf-git](https://github.com/junegunn/fzf-git.sh) - look for git related things with fzf
  - [bat](https://github.com/sharkdp/bat) - better cat
  - [eza](https://github.com/eza-community/eza) - better ls
  - [delta](https://github.com/dandavison/delta) - better git diff
  - [thefuck](https://github.com/nvbn/thefuck) - auto correct mistyped commands
  - [zoxide](https://github.com/ajeetdsouza/zoxide) - better cd

### Relevant Files

- [.zshrc](.zshrc) - Zsh Shell Configuration

## Fish Setup

### Plugins

- jorgebucaran/fisher - fish plugin management
- patrickf1/fzf.fish - fzf config for fish
- jorgebucaran/autopair.fish - autopair ()[]''{}...
- jhillyerd/plugin-git - git shortcuts

### Setup Requires

- [fisher](https://github.com/jorgebucaran/fisher) - fish plugin management
- CLI tools
  - [fzf](https://github.com/junegunn/fzf) - command line fuzzy finder
  - [fd](https://github.com/sharkdp/fd) - better find
  - [bat](https://github.com/sharkdp/bat) - better cat
  - [eza](https://github.com/eza-community/eza) - better ls
  - [thefuck](https://github.com/nvbn/thefuck) - auto correct mistyped commands
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

# Yabai Tiling Window Manager Setup (macOS)

✍🏼 Blog Post: [How To Setup And Use The Yabai Tiling Window Manager On Mac](https://josean.com/posts/yabai-setup)

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

✍🏼 Blog Post: [How To Make An Amazing Custom Menu Bar For Your Mac With Sketchybar](https://josean.com/posts/sketchybar-setup)

## Setup Requires

- sketchybar: `brew tap FelixKratz/formulae` and `brew install sketchybar`

- jq (json command line processor): `brew install jq`

- SF Pro Font: `brew tap homebrew/cask-fonts` and `brew install font-sf-pro`

- SF Symbols: `brew install --cask sf-symbols`:

- Sketchybar App Font:

  ```bash
  curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.16/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
  ```

## Relevant Files

- [.config/sketchybar](.config/sketchybar)

# Tmux Setup

✍🏼 Blog Post: [How To Use and Configure Tmux Alongside Neovim](https://josean.com/posts/tmux-setup)

## Setup Requires

- tpm - tmux plugin manager

  ```bash
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ```

## Relevant Files

- [.tmux.conf](.tmux.conf) - Tmux Configuration File

# Neovim Setup

## Setup Requires

- Neovim >= **0.9.0** (needs to be built with **LuaJIT**)

- Git >= **2.19.0** (for partial clones support)

- [LazyVim](https://www.lazyvim.org/)

- a [Nerd Font](https://www.nerdfonts.com/)(v3.0 or greater) ***(optional, but needed to display some icons)\***

- [lazygit](https://github.com/jesseduffield/lazygit) ***(optional)\***

- a **C** compiler for `nvim-treesitter`. See [here](https://github.com/nvim-treesitter/nvim-treesitter#requirements)

- for 

  telescope.nvim

  *(optional)*

  - **live grep**: [ripgrep](https://github.com/BurntSushi/ripgrep)
  - **find files**: [fd](https://github.com/sharkdp/fd)

- a terminal that support true color and 

  undercurl:

  - [kitty](https://github.com/kovidgoyal/kitty) ***(Linux & Macos)\***
  - [wezterm](https://github.com/wez/wezterm) ***(Linux, Macos & Windows)\***
  - [alacritty](https://github.com/alacritty/alacritty) ***(Linux, Macos & Windows)\***
  - [iterm2](https://iterm2.com/) ***(Macos)\***

## Relevant Files

- [.config/nvim/](.config/nvim/)
