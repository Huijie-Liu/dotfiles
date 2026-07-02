fzf --fish | source
fzf_configure_bindings --directory=\ct --git_status=\cgs --git_log=\cgl --history=\cr

set fzf_preview_dir_cmd eza --all --color=always
set fzf_fd_opts --hidden --max-depth 5

export FZF_DEFAULT_OPTS="--layout=reverse"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
