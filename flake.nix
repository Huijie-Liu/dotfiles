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
          pkgs.eza
          pkgs.bat
          pkgs.fzf
          pkgs.fd
          pkgs.ripgrep
          pkgs.yazi
          pkgs.atuin
          pkgs.zoxide

          # Terminal
          pkgs.tmux
          pkgs.zellij

          # Editor
          pkgs.neovim

          # VCS
          pkgs.git
          pkgs.delta
          pkgs.lazygit
          pkgs.gitmoji-cli

          # Monitor
          pkgs.htop
          pkgs.btop

          # MISC
          pkgs.duf
          pkgs.ncdu
          pkgs.dust
          pkgs.fastfetch
          pkgs.tlrc
          pkgs.clash-meta
          pkgs.metacubexd
          pkgs.scc
          pkgs.tokei
        ];

        shellHook = ''
          exec fish
        '';
      };
    };
}
