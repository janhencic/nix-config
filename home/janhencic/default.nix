{ config, pkgs, ... }:

{
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
      fzf
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
    ];
  };
  
  programs.git = {
    enable = true;
    userName = "janhencic";
    userEmail = "jan@hencic.com";
  };
}
