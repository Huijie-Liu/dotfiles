function _fzf_zoxide --description "Zoxide database + fzf fuzzy directory jump"
    # 使用 zoxide 原生命令避免别名干扰
    set -f zoxide_cmd (command -v zoxide)
    set -f fzf_arguments --ansi --reverse --height 40% $fzf_directory_opts

    # 获取当前命令行标记并解析路径
    set -f token (commandline --current-token)
    set -f expanded_token (eval echo -- $token)
    set -f unescaped_exp_token (string unescape -- $expanded_token)

    # 动态设置搜索根目录
    if string match --quiet -- "*/" $unescaped_exp_token && test -d "$unescaped_exp_token"
        set base_dir $unescaped_exp_token
        set --prepend fzf_arguments --prompt="Zoxide in $base_dir> " --preview="ls -lAh --color=always $base_dir{}"
        set -f query_results ($zoxide_cmd query -l | grep "^$base_dir" | _fzf_wrapper $fzf_arguments)
    else
        set --prepend fzf_arguments --prompt="Zoxide> " --preview="ls -lAh --color=always {}" --query="$unescaped_exp_token"
        set -f query_results ($zoxide_cmd query -l | _fzf_wrapper $fzf_arguments)
    end

    # 处理选择结果
    if test $status -eq 0
        if set -q fzf_arguments[(contains -- --multi $fzf_arguments)]
            # 多选模式：插入路径到命令行
            commandline --current-token --replace -- (string escape -- $query_results | string join ' ')
        else
            # 单选模式：直接跳转目录
            cd "$query_results"
            commandline -f repaint
        end
    else
        commandline -f repaint
    end
end