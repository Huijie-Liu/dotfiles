# 文件管理
abbr --add ls "eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions"
abbr --add l "eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions --all"
abbr --add ll "eza --color=always --long --git --icons=always --all --no-filesize --no-time --no-user --no-permissions"
abbr --add la "eza --color=always --git --no-filesize --icons=always --all"
abbr --add d "dirs -v"
abbr --add .. "cd .."
abbr --add ... "cd ../.."

# 历史记录
abbr --add h "history -10"
abbr --add hc "history -c"
abbr --add hg "history | grep"

# 文件操作
abbr --add md "mkdir -p"
abbr --add rd rmdir

# Tmux 控制
abbr --add ta "tmux attach"
abbr --add tl "tmux list-session"
abbr --add ts "tmux new-session"

# Zellij
abbr --add zj zellij
abbr --add za "zellij attach"
abbr --add zl "zellij list-sessions"
abbr --add zs "zellij --session"
abbr --add zk "zellij kill-session"
abbr --add zka "zellij kill-all-sessions"
abbr --add zjl "zellij --layout"

# 终端控制
abbr --add c clear
abbr --add x exit
abbr --add r "source ~/.config/fish/config.fish"
abbr --add e "nvim ~/.config/fish/config.fish"
abbr --add f "find . -name"
abbr --add v nvim
abbr --add pd prevd
abbr --add nd nextd
abbr --add dud "du -h -d 1"
abbr --add duds "du -h -d 1 | sort -h"

# Nix
set NIX "~/.nix-portable/nix-portable nix"
abbr --add nix $NIX
abbr --add ns --set-cursor $NIX" shell nixpkgs#%"
abbr --add nr --set-cursor $NIX" run nixpkgs#%"
abbr --add nf --set-cursor $NIX" flake"

# 自定义
abbr --add nvs nvidia-smi
abbr --add lg lazygit
abbr --add clash "bash ~/.app/clash-for-linux/start.sh"
abbr --add ff fastfetch

# 全局快捷键
abbr --add L --position anywhere --set-cursor "% | less"
abbr --add G --position anywhere --set-cursor "| grep"
