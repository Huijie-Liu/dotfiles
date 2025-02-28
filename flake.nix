{
  description = "Nix Development Environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @inputs:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: nixpkgs.lib.genAttrs systems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSystem ({ pkgs }: {
        default = pkgs.mkShellNoCC {

          buildInputs = with pkgs; [
            # Shell增强
            fish starship eza bat fzf fd ripgrep yazi atuin zoxide
            # 终端工具
            tmux zellij
            # 编辑器
            neovim
            # VCS工具
            git lazygit delta gitmoji-cli
            # 网络工具
            curl wget
            # 系统监控
            htop btop
            # 其他工具
            duf ncdu dust tealdeer fastfetch scc tokei micromamba
            # Proxy
            clash-meta metacubexd
          ];

          # 环境初始化
          shellHook = ''
            export SHELL=$(which fish)
            exec fish
          '';
        };
      });
    };
}
