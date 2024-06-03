# Homebrew
eval (/opt/homebrew/bin/brew shellenv)


# ----- greetings -----
set fish_greeting # remove the greeting

# set fish_greeting "
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣶⣶⡶⣶⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣲⣿⡿⠋⣹⣾⣿⣿⣿⠟⣻⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⢦⣾⣿⣿⠻⠷⣿⣿⡿⢏⠠⣿⣿⣿⣿⣶⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣼⣿⣿⣏⣿⠿⠿⠿⣅⣬⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⣿⣿⣿⣿⡄⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⣽⣿⣿⣿⣿⡄⣠⠤⢴⣗⠹⢿⡍⡀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⡿⣷⢮⠩⠊⠻⠿⡇⠀⠈⠁⣀⣶⣦⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠡⢤⡴⠀⠁⠀⠀⠁⠀⠀⠐⠉⢿⣿⡄⠑⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣐⡀⠀⠀⠀⠀⢀⠔⠁⠀⠀⢹⠀⠀⠈⠐⡤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣾⣿⣿⣦⣀⣠⣾⠁⠀⠀⠀⠀⢨⠀⠀⠀⠀⡇⠀⠉⠒⠦⡀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⡿⣿⣿⣿⣷⠀⠀⢀⢤⡇⠀⠀⠀⠀⡏⠘⠂⢀⠀⠠⡙⣄⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠾⣻⡿⠏⠀⠀⢀⣿⣿⣿⣿⣿⣾⣾⣿⠀⠀⠀⠀⠀⡇⠀⠀⠀⠈⢒⢔⣼⣷⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⢻⣿⣿⡷⠖⠁⢿⣿⣿⣿⣿⣿⡿⣷⠀⠀⠀⠀⠀⡇⢀⠄⠀⣀⠔⠑⠉⢻⡇⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣞⠝⢧⡈⢿⣧⠀⠀⠀⢸⣿⣿⣿⣾⣶⣿⡟⢴⣶⣶⣤⣤⡇⡎⢀⡴⠁⠀⠀⢀⣿⣿⡀⠀⠀
# ⠠⠄⣤⠀⣀⠀⠀⠀⠀⠀⠀⠀⢠⣼⣷⡤⢝⡢⠷⣼⣿⡆⠀⠀⢸⣿⣿⣿⣿⣿⣿⠗⠀⠹⣿⠏⠉⣸⠃⣿⢁⠼⣍⣡⢬⣥⣾⣧⠀⠀
# ⠀⠀⠀⠀⠀⠉⠑⠒⠰⠂⠄⢠⣿⣭⠭⣍⣑⢙⣷⣾⣿⣿⠀⠀⢸⣿⣿⣿⣿⣿⣿⠀⠀⢦⡿⢀⣠⡿⠖⣿⣂⠜⣿⣗⠶⠿⠿⣿⡀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠁⠀⠉⠙⢿⣿⣿⡇⠀⣼⣿⣿⣿⣿⣿⣿⠀⢀⣿⢋⣀⣿⠁⠀⣿⠇⠀⢿⣟⣀⣀⣬⣿⣷⠀
# ⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⢶⡄⠀⢽⣿⣷⠻⣿⣿⣿⣿⣿⣿⣿⠠⣾⣿⣶⣴⣿⣾⣿⣿⡔⣒⣚⣛⡛⠛⠛⣩⣿⡄
# ⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢉⢻⣿⡄⣼⣿⡿⢾⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⡿⠿⠟⠛⠛⠻⢖⠲⢔⢾⣭⣓⠦⣽⣿⡇
# ⠘⣿⣿⣶⣦⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣿⡿⠛⠉⠀⠀⠈⠉⠛⠛⢿⢏⣩⣟⢿⠥⣶⣦⡀⠀⠀⠀⠀⠈⠳⣤⡈⠻⣷⣜⣿⡟
# ⠀⢹⣿⣿⣿⣿⣿⣷⣦⣴⣶⣤⣀⡀⡀⠀⠀⣉⢀⠀⡠⠂⠀⠀⡀⠀⠀⠀⢠⣾⣿⣂⣴⡺⢿⣿⣿⣄⠀⠀⢀⠀⠀⣯⣏⣷⣦⣽⣾⠁
# ⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⡆⡰⣁⣴⠟⢈⣡⣤⣀⣀⣻⣿⣽⣿⣿⣿⣭⣿⣿⣿⣆⠀⠈⠀⠀⣿⣿⣿⣿⣿⠃⠀
# ⠀⠒⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣿⢧⣿⣧⣶⣿⣿⠭⠍⠉⣹⡦⢤⣀⠀⠠⢤⣾⣿⡿⢋⣠⣴⣷⣾⠿⠿⠿⠟⠛⠒⠠
# ⠀⠀⠀⠀⠀⠀⠉⠙⠛⠛⠿⢿⣿⣿⣿⣿⣿⣿⡼⠿⢛⢏⣻⣭⠴⠶⡚⣋⣹⡇⡇⠚⠙⠂⣼⣿⠀⠈⠉⢉⣁⣠⣠⣤⣀⣄⡀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠙⠛⠛⠓⠒⠒⠉⠁⠠⠦⠿⠛⠋⠉⡷⠻⠟⠒⠭⠿⡋⠀⢠⣼⣞⣿⣿⡿⣿⣿⠽⠃⠀⠀⠀
# "

# function fish_greeting
#     echo -e "     \e[32m██╗   \e[34m█████╗  \e[31m██╗   ██╗\e[0m"
#     echo -e "     \e[32m██║  \e[34m██╔══██╗ \e[31m╚██╗ ██╔╝\e[0m"
#     echo -e "     \e[32m██║  \e[34m███████║  \e[31m╚████╔╝\e[0m"
#     echo -e "\e[32m██   ██║  \e[34m██╔══██║   \e[31m╚██╔╝\e[0m"
#     echo -e "\e[32m╚█████╔╝  \e[34m██║  ██║    \e[31m██║\e[0m"
#     echo -e "\e[32m ╚════╝   \e[34m╚═╝  ╚═╝    \e[31m╚═╝\e[0m"
# end


# ----- aliases -----
alias proxy="export all_proxy=http://127.0.0.1:7890 && echo 代理成功"
alias ydl="youtube-dl"
alias dw="download_wallpaper"
alias c="clear"
alias x="exit"
alias python="python3"
alias lg="lazygit"


# bind clear-screen shortcut from \cl to \el
bind --preset \el clear-screen


# ----- starship -----
# starship init fish | source


# ----- fzf -----
fzf_configure_bindings --directory=\ct --git_status=\cgs --git_log=\cgl --history=\cr --processes=\cp
set fzf_preview_dir_cmd eza --all --color=always
set fzf_fd_opts --exclude .git --hidden --max-depth 5


# ----- Eza (better ls) -----
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias l="ls -la"


# ----- Zoxide (better cd) -----
zoxide init fish | source
alias cd="z"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/miniconda3/bin/conda
    eval /opt/miniconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
        . "/opt/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /opt/miniconda3/bin $PATH
    end
end
# <<< conda initialize <<<
