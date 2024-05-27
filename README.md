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

✍🏼 Blog Post: [How I Setup Neovim On My Mac To Make It AMAZING In 2024](https://josean.com/posts/how-to-setup-neovim-2024)

_If you clone the repo into your machine and use the config by copying .config/nvim to your home folder, wait for the plugins, language servers and parsers to install with lazy.nvim, Mason and nvim-treesitter.
If you are opening a lua file or another file I have language servers configured for, like html, css or javascript/typescript, you might also get an error saying that the server failed to start. This is because Mason hasn't installed it yet. Press enter to continue, Mason will automatically install it._

## Setup Requires

- True Color Terminal Like: [iTerm2](https://iterm2.com/)
- [Neovim](https://neovim.io/) (Version 0.9 or Later)
- [Nerd Font](https://www.nerdfonts.com/) - I use Meslo Nerd Font
- [Ripgrep](https://github.com/BurntSushi/ripgrep) - For Telescope Fuzzy Finder
- XCode Command Line Tools
- If working with typescript/javascript and the typescript language server like me. You might need to install node/npm.

If you're on mac, like me, you can install iTerm2, Neovim, Meslo Nerd Font, Ripgrep and Node with homebrew.

iTerm2:

```bash
brew install --cask iterm2
```

Nerd font:

```bash
brew tap homebrew/cask-fonts
brew install font-meslo-lg-nerd-font
```

Neovim:

```bash
brew install neovim
```

Ripgrep:

```bash
brew install ripgrep
```

Node/Npm:

```bash
brew install node
```

For XCode Command Line Tools do:

```bash
xcode-select --install
```

## Plugins

#### Plugin Manager

- [folke/lazy.nvim](https://github.com/folke/lazy.nvim) - Amazing plugin manager

#### Dependency For Other Plugins

- [nvim-lua/plenary](https://github.com/nvim-lua/plenary.nvim) - Useful lua functions other plugins use

#### Preferred Colorscheme

- [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) - tokyonight colorscheme (I modified some colors it in config)

#### Navigating Between Neovim Windows and Tmux

- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - navigate b/w nvim splits & tmux panes with CTRL+h,j,k,l

#### Essentials

- [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround) - manipulate surroundings with "ys", "ds", and "cs"
- [gbprod/substitute.nvim](https://github.com/gbprod/substitute.nvim) - replace things with register with "s" and "S"

#### File Explorer

- [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)

#### VS Code Like Icons

- [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)

#### Neovim Greeter

- [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim) -- neovim greeter on startup

#### Auto Sessions

- [rmagatti/auto-session](https://github.com/rmagatti/auto-session) - auto save neovim sessions/restore with keymap

#### Statusline

- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Better statusline

#### Bufferline

- [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - Better looking tabs

#### Keymap Suggestions

- [folke/which-key.nvim](https://github.com/folke/which-key.nvim) - Get suggested keymaps as you type

#### Fuzzy Finder

- [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) - Dependency for better performance
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy Finder
- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) - select/input ui improvement

#### Autocompletion

- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion plugin
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - Completion source for text in current buffer
- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) - Completion source for file system paths
- [onsails/lspkind.nvim](https://github.com/onsails/lspkind.nvim) - Vs Code Like Icons for autocompletion

#### Snippets

- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet engine
- [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Useful snippets for different languages
- [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - Completion source for snippet autocomplete

#### Managing & Installing Language Servers, Linters & Formatters

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) - Install language servers, formatters and linters

#### LSP Configuration

- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Bridges gap b/w mason & lspconfig
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Easy way to configure lsp servers
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - Smart code autocompletion with lsp

#### Trouble.nvim

- [folke/trouble.nvim](https://github.com/folke/trouble.nvim) - nice way to see diagnostics and other stuff

#### Formatting & Linting

- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) - Easy way to configure formatters
- [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint) - Easy way to configure linters
- [WhoIsSethDaniel/mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) - Auto install linters & formatters on startup

#### Comments

- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) - toggle comments with "gc"
- [JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) - Requires treesitter
- [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - highlight/search for comments like todo/hack/bug

#### Treesitter Syntax Highlighting, Autoclosing & Text Objects

- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Treesitter configuration
- [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) - Treesitter configuration
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Autoclose brackets, parens, quotes, etc...
- [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - Autoclose tags

#### Indent Guides

- [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - Indent guides with treesitter integration

#### Git

- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Show modifications on left hand side and interact with git hunks
- [kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) - Use lazygit within Neovim

## Relevant Files

- [.config/nvim](.config/nvim)
