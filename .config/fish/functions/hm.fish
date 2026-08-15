function hm --description "home-manager switch"
    nix run $HOME/.dotfiles/.config/home-manager#home-manager -- switch --flake $HOME/.dotfiles/.config/home-manager#jay
end
