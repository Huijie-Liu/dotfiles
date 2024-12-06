# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
set __conda_setup (eval $HOME/.miniconda/bin/conda 'shell.fish' 'hook' 2> /dev/null)
if test $status -eq 0
    eval $__conda_setup
else
    if test -f "$HOME/.miniconda/etc/profile.d/conda.fish"
        source "$HOME/.miniconda/etc/profile.d/conda.fish"
    else
        set -x PATH "$HOME/.miniconda/bin:$PATH"
    end
end
set -e __conda_setup
# <<< conda initialize <<<

