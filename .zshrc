if [[ -d "$HOME/.config/zsh" ]]; then
    for config_file in "$HOME/.config/zsh"/*.zsh; do
        if [[ -r "$config_file" ]]; then
            source "$config_file"
        fi
    done
fi