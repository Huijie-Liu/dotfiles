{ config, pkgs, ... }: {
  home.username = "jay";
  home.homeDirectory = "/home/jay";

  home.packages = with pkgs; [
    file
    fd
    fish
    gh
    ripgrep
    jq
    _7zz
    ffmpeg
    poppler
    resvg
    imagemagick
    zoxide
    neovim
    yazi
    zellij
    lazydocker
    lazygit
    fastfetch
    codex
    claude-code
  ];

  nixpkgs = {
    config = {
    allowUnfree = true;
    };
  };

  home.stateVersion = "26.05";
}
