function _fzf_ripgrep -d 'Search using ripgrep with fzf preview'
    rg --column --line-number --no-heading --color=always --smart-case '' | _fzf_wrapper --ansi \
        --delimiter ':' \
        --scheme=path \
        --preview 'bat --style=numbers,header --color=always --highlight-line {2} {1}' \
        --preview-window 'bottom:50%,border-top,+{2}+3/3,wrap' \
        --prompt="Ripgrep> " \
        --query=(commandline) \
        $fzf_ripgrep_opts | awk -F ':' '{print $1, $2}' | read -l file line
    and $EDITOR "+$line" "$file"
    commandline --function repaint
end