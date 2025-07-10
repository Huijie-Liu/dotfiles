# Basic
abbr --add c clear
abbr --add v nvim
abbr --add L --position anywhere --set-cursor "% | less"
abbr --add G --position anywhere --set-cursor "| grep"

# Git
abbr --add g git
abbr --add gs "git status"
abbr --add ga "git add ."
abbr --add gc "git commit -m"
abbr --add gp "git push"
abbr --add gl "git pull"
abbr --add gco "git checkout"
abbr --add gcb "git checkout -b"
abbr --add gd "git diff"
abbr --add gr "git restore"
abbr --add grs "git restore --staged"
abbr --add gb "git branch"
abbr --add gam "git commit --amend"

# File system
abbr --add ls 'lsd --group-directories-first'
abbr --add l 'lsd -l --group-directories-first'
abbr --add ll 'lsd -lA --group-directories-first'
abbr --add la 'lsd -A --group-directories-first'
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

# Tool
abbr --add lg lazygit
abbr --add ff fastfetch
abbr --add one onefetch
abbr --add mm micromamba
abbr --add 7z 7zz
abbr --add cl claude
