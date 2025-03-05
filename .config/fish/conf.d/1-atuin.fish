set NAME atuin
if not command -v $NAME >/dev/null
    echo $NAME "is not installed."
else
    atuin init fish | source
end
