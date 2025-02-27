# 基本别名
abbr --add c clear
abbr --add x exit
abbr --add e "nvim ~/.config/fish/config.fish"
abbr --add r "source ~/.config/fish/config.fish"
abbr --add v nvim
abbr --add g git
abbr --add L --position anywhere --set-cursor "% | less"
abbr --add G --position anywhere --set-cursor "| grep"

# 文件管理
abbr --add ls eza
abbr --add l "eza -A -1 --icons=always"
abbr --add la "eza -Al --git --icons=always"
abbr --add ll "eza -A --icons=always"
abbr --add lt "eza -T -L 2 --icons=always"
abbr --add cd z
abbr --add md "mkdir -p"
abbr --add rd rmdir

# 历史记录
abbr --add h "history -10" # 最近10条历史记录
abbr --add hg "history | grep " # 搜索历史记录

# Tmux
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

# Homebrew
abbr --add b brew
abbr --add bi "brew install"
abbr --add bu "brew uninstall"
abbr --add bc "brew cleanup --prune=all"
abbr --add bs "brew search"
abbr --add bU "brew upgrade"
abbr --add ba "brew abv"
abbr --add bd "brew desc"
abbr --add bD "brew doctor"
abbr --add bo "brew outdated"
abbr --add bl "brew list"
abbr --add bI "brew info"

# 系统工具
abbr --add proxy "export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890"

# 开发工具
abbr --add lg lazygit

# 其他工具
abbr --add dw download_wallpaper
abbr --add ff fastfetch
