umask 022

[[ ! -d ~/.config/zsh ]] && mkdir -p ~/.config/zsh

if [ -d ~/.config/zsh ]; then
    for conf in ~/.config/zsh/*.zsh; do
        if [[ -r $conf ]]; then
            source $conf
        else
            echo "\033[0;31mWarning: Unable to read config file $conf\033[0m"
        fi
    done
fi

# if [ -e /data/liuhuijie/.nix-profile/etc/profile.d/nix.sh ]; then . /data/liuhuijie/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

