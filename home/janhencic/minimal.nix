{ config, pkgs, pkgs-unstable, nil, ... }:
let
  jan_nvim = import ./nvim/default.nix { pkgs = pkgs-unstable; };
  drata = (import ./../../drata.nix { pkgs = pkgs; stdenv = pkgs.stdenv; });
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
      nil

      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      jan_nvim
      tree
      tmux
      shellcheck
      jq
      htop
      drata
    ];
  };
}
