# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/.miniconda/bin/conda
    eval $HOME/.miniconda/bin/conda "shell.fish" hook $argv | source
else
    if test -f "$HOME/.miniconda/etc/fish/conf.d/conda.fish"
        . "$HOME/.miniconda/etc/fish/conf.d/conda.fish"
    else
        set -x PATH $HOME/.miniconda/bin $PATH
    end
end
# <<< conda initialize <<<
