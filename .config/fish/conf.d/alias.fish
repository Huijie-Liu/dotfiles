# Basic
abbr --add c clear
abbr --add v nvim
abbr --add ls 'lsd --group-directories-first'
abbr --add l 'lsd -l --group-directories-first'
abbr --add ll 'lsd -lA --group-directories-first'
abbr --add la 'lsd -A --group-directories-first'
abbr --add cd z
abbr --add md "mkdir -p"
abbr --add rd rmdir

# Homebrew
abbr --add bi "brew install"
abbr --add bu "brew uninstall"
abbr --add bc "brew cleanup --prune=all"
abbr --add bU "brew update && brew upgrade && brew cleanup --prune=all"

# Tool
abbr --add zj zellij
abbr --add lg lazygit
abbr --add ff fastfetch
abbr --add one onefetch
abbr --add mm micromamba
abbr --add 7z 7zz
