{ config, pkgs, ... }:
let 
  jan_nvim = import ./nvim/default.nix { inherit pkgs; };
in
{
  imports = [
    ./alacritty.nix
    ./bash.nix
    ./fzf.nix
    ./git.nix
    ./i3
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

    packages = with pkgs; [
      alacritty
      chromium
      pass
      git
      sumneko-lua-language-server
      selene
      lazygit
      gcc
      ripgrep 
      deluge
      pavucontrol
      google-chrome
      slack

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
