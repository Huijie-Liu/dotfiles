# FZF Integration for Fish Shell

# Core wrapper
function _fzf_wrapper
    set -lx SHELL (command -s fish)
    not set -q FZF_DEFAULT_OPTS[1] && not set -q FZF_DEFAULT_OPTS_FILE[1] && set -lx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*"'
    fzf $argv
end

# Preview helper
function _fzf_preview_file
    test -e "$argv[1]" || return 1

    set -l target "$argv[1]"

    if test -L "$target"
        echo "🔗 $target → "(readlink "$target")
        echo
        _fzf_preview_file (readlink "$target")
    else if test -d "$target"
        command -q eza && eza --all --classify --color=always --icons "$target" || ls -la --color=always "$target"
    else if test -f "$target"
        command -q bat && bat --style=numbers --color=always "$target" || head -200 "$target"
    else
        file "$target"
    end
end

# Search functions
function _fzf_search_directory
    set -l fd_opts --color=always --strip-cwd-prefix --hidden --exclude=.git
    set -l fzf_args --multi --ansi
    set -l token (commandline --current-token)

    test -d "$token" && set fzf_args --query="$token" --select-1 && set fd_opts $fd_opts --search-path="$token"
    set -q fzf_fd_opts && set fd_opts $fd_opts $fzf_fd_opts
    set -q fzf_directory_opts && set fzf_args $fzf_args $fzf_directory_opts

    set -l selected (fd $fd_opts 2>/dev/null | _fzf_wrapper $fzf_args --preview='_fzf_preview_file {}')
    test $status -eq 0 && commandline --current-token --replace -- (string escape -- $selected | string join ' ')
    commandline --function repaint
end

function _fzf_search_history
    set -l time_format "%m-%d %H:%M:%S"
    set -l fzf_args --no-multi
    set -q fzf_history_time_format && set time_format $fzf_history_time_format
    set -q fzf_history_opts && set fzf_args $fzf_args $fzf_history_opts

    set -l selected (history --null --show-time="$time_format | " | _fzf_wrapper $fzf_args --read0 --print0 --query=(commandline) --preview="echo -- {4..} | fish_indent --ansi" | string split0 | string join "")
    test $status -eq 0 && commandline --replace -- $selected
    commandline --function repaint
end

function _fzf_search_processes
    set -l fzf_args --multi --ansi --header="Select processes with <TAB>, confirm with <ENTER>"
    set -q fzf_processes_opts && set fzf_args $fzf_args $fzf_processes_opts

    set -l selected (ps -A -opid,stat,cputime,command | _fzf_wrapper $fzf_args --preview="ps -fp {1}" --preview-window="3,wrap" | string match --regex -- '^\s*(?<pid>\d+)' | string trim)
    test $status -eq 0 && commandline --current-token --replace -- (string join ' ' $selected)
    commandline --function repaint
end

function _fzf_ripgrep
    set -l fzf_args --ansi --no-multi --delimiter=:
    set -q fzf_ripgrep_opts && set fzf_args $fzf_args $fzf_ripgrep_opts

    set -l selected (rg --color=always --line-number --no-heading --smart-case . 2>/dev/null | _fzf_wrapper $fzf_args --preview='bat --style=numbers --color=always --highlight-line {2} {1}' --preview-window='~3:+{2}+3/2')
    if test $status -eq 0
        set -l parts (string split --max 2 : $selected)
        if test -n "$EDITOR"
            string match --quiet "*vim*" "$EDITOR" && $EDITOR +$parts[2] $parts[1] || $EDITOR $parts[1]
        else
            echo "Opening $parts[1] at line $parts[2]"
        end
    end
    commandline --function repaint
end

function _fzf_zoxide
    set -l selected (zoxide query --list | _fzf_wrapper --no-multi --preview="_fzf_preview_file {}")
    test $status -eq 0 && cd $selected && commandline --function repaint
end

# Key bindings
function fzf_configure_bindings
    bind \ct _fzf_search_directory
    bind \ep _fzf_search_processes
    bind \er _fzf_ripgrep
    bind \ec _fzf_zoxide

    bind --mode insert \ct _fzf_search_directory
    bind --mode insert \ep _fzf_search_processes
    bind --mode insert \er _fzf_ripgrep
    bind --mode insert \ec _fzf_zoxide
end

# Auto-configure
fzf_configure_bindings
