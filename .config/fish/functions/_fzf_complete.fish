function _fzf_complete -d 'fzf completion'
    # 解析命令参数（保持原始逻辑）
    set -l cmd (commandline -co) (commandline -ct)
    switch $cmd[1]
        case env sudo
            for i in (seq 2 (count $cmd))
                switch $cmd[$i]
                    case '-*'
                    case '*=*'
                    case '*'
                        set cmd $cmd[$i..-1]
                        break
                end
            end
    end
    set cmd (string join -- ' ' $cmd)

    # 获取补全列表
    set -l complist (complete -C$cmd)
    set -l result  # 明确初始化为空数组

    # 使用 _fzf_wrapper 进行选择
    string join -- \n $complist | sort | _fzf_wrapper -m --select-1 --exit-0 \
        --header "(commandline)" \
        --prompt="Complete> " \
        --preview="echo 'Completion preview: {1}'" \
        --preview-window="bottom:3:wrap" \
        --query=(commandline -t) | cut -f1 | while read -l r
        set result $result $r
    end

    # 关键修复：检查结果数组是否为空
    if test (count $result) -eq 0
        commandline -f repaint
        return
    end

    # 处理结果插入命令行（保持原始转义逻辑）
    set prefix (string sub -s 1 -l 1 -- (commandline -t))
    for i in (seq (count $result))  # 当 $result 非空时安全执行
        set -l r $result[$i]
        switch $prefix
            case "'"
                commandline -t -- (string escape -- $r)
            case '"'
                if string match '*"*' -- $r >/dev/null
                    commandline -t -- (string escape -- $r)
                else
                    commandline -t -- '"'$r'"'
                end
            case '~'
                commandline -t -- (string sub -s 2 (string escape -n -- $r))
            case '*'
                commandline -t -- (string escape -n -- $r)
        end
        [ $i -lt (count $result) ]; and commandline -i ' '
    end

    commandline -f repaint
end