# 文件管理
abbr --add ls 'lsd --group-directories-first'
abbr --add l 'lsd -l --group-directories-first'
abbr --add ll 'lsd -lA --group-directories-first'
abbr --add la 'lsd -A --group-directories-first'
abbr --add lt 'lsd --tree --depth 2 --group-directories-first'
abbr --add lta 'lsd --tree --depth 2 -a --group-directories-first'

# 目录导航
abbr --add .. 'cd ..'
abbr --add ... 'cd ../..'

# 文件操作
abbr --add md 'mkdir -p'
abbr --add rd rmdir

# Tmux 控制
abbr --add ta 'tmux attach'
abbr --add tl 'tmux list-session'
abbr --add ts 'tmux new-session'

# Zellij 控制
abbr --add zj zellij
abbr --add za 'zellij attach'
abbr --add zl 'zellij list-sessions'
abbr --add zs 'zellij --session'
abbr --add zk 'zellij kill-session'
abbr --add zka 'zellij kill-all-sessions'
abbr --add zjl 'zellij --layout'

# 终端控制
abbr --add c clear
abbr --add r 'source ~/.config/fish/config.fish'
abbr --add e 'nvim ~/.config/fish/config.fish'
abbr --add v nvim

# 自定义命令
abbr --add nvs nvidia-smi
abbr --add lg lazygit
abbr --add ff fastfetch
abbr --add mm micromamba
abbr --add one onefetch
abbr --add p pixi
abbr --add pgi pixi g i
abbr --add pgl pixi g ls
abbr --add cl claude
