function _fzf_wrapper --description "Prepares some environment variables before executing fzf."
    # Make sure fzf uses fish to execute preview commands, some of which
    set -f --export SHELL (command --search fish)

    set --query FZF_DEFAULT_OPTS FZF_DEFAULT_OPTS_FILE
    if test $status -eq 2
        set --export FZF_DEFAULT_OPTS '
          --style default --cycle --layout=reverse --height=~90%
          --border="rounded" --border-label="" --preview-window="border-rounded"
          --prompt="> " --marker=">" --pointer="◆" --scrollbar="│"
          --bind "tab:down,shift-tab:up,space:toggle+down"
        '
    end

    fzf $argv
end
