zsh_config_dir="${ZDOTDIR:-$HOME/.config/zsh}"

for config_name in env aliases plugins completions fzf; do
    config_file="$zsh_config_dir/${config_name}.zsh"
    [[ -r "$config_file" ]] && source "$config_file"
done

unset config_file config_name zsh_config_dir
