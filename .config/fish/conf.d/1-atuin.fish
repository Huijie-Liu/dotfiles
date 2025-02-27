set NAME atuin
if not command -v $NAME >/dev/null
    echo $NAME "is not installed."
else
    # set -gx ATUIN_NOBIND true
    atuin init fish | source

    bind \cq _atuin_search
    bind -M insert \cq _atuin_search
end
