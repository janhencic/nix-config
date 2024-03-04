{ config, pkgs, pkgs-unstable, ... }:
let
  jan_nvim = import ./nvim/default.nix { pkgs = pkgs-unstable; };
in
{
  imports = [
    ./bash
    ./fzf.nix
    ./git.nix
    ./tmux
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  fonts.fontconfig.enable = true;

  home = {
    username = "janhencic";
    homeDirectory = "/home/janhencic";
    stateVersion = "22.11";
    sessionVariables = { EDITOR = "nvim"; };

    packages = with pkgs; [
      pass
      git
      sumneko-lua-language-server
      selene
      lazygit
      gcc
      ripgrep
      deluge
      pavucontrol
      awscli

      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      jan_nvim
      tree
      tmux
      shellcheck
      jq
      htop
    ];
  };
}
