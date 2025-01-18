set NAME starship
if not command -v $NAME >/dev/null
    echo $NAME "is not installed."
else
    starship init fish | source
end
