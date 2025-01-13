{
  description = "My Nix develop environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShell.${system} = pkgs.mkShell {
        buildInputs = [
          # Shell
          pkgs.fish
          pkgs.starship
          pkgs.atuin
          pkgs.zoxide
          pkgs.starship

          # Terminal
          pkgs.tmux
          pkgs.zellij

          # Editor
          pkgs.neovim
          pkgs.eza
          pkgs.bat
          pkgs.fzf
          pkgs.fd
          pkgs.yazi
          pkgs.duf
          pkgs.ncdu
          pkgs.dust

          # VCS
          pkgs.git
          pkgs.delta
          pkgs.lazygit
          pkgs.gitmoji-cli

          # Monitor
          pkgs.htop
          pkgs.btop

          # MISC
          pkgs.fastfetch
          pkgs.tlrc
          pkgs.go
          pkgs.clash-meta
          pkgs.metacubexd
        ];

        shellHook = ''
          exec fish
        '';
      };
    };
}
