# 基本别名
abbr --add c clear
abbr --add e "nvim ~/.config/fish"
abbr --add v nvim
abbr --add g git
abbr --add L --position anywhere --set-cursor "% | less"
abbr --add G --position anywhere --set-cursor "| grep"

# 文件管理
abbr --add ls lsd
abbr --add l 'lsd -l'
abbr --add ll 'lsd -la'
abbr --add la 'lsd -A'
abbr --add lla 'lsd -lA'
abbr --add llg 'lsd -lAg'
abbr --add lt 'lsd --tree --depth 2'
abbr --add lta 'lsd --tree --depth 2 -a'
abbr --add cd z
abbr --add md "mkdir -p"
abbr --add rd rmdir

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
abbr --add bU "brew update && brew upgrade && brew cleanup --prune=all"
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
abbr --add ff fastfetch
abbr --add one onefetch
abbr --add mm micromamba
abbr --add 7z 7zz
abbr --add tldr --set-cursor "curl cheat.sh/%"
