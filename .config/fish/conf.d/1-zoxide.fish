set NAME zoxide
if not command -v $NAME >/dev/null
    echo $NAME "is not installed."
else
    zoxide init fish | source
end
