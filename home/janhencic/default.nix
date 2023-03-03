{ config, pkgs, ... }:
let 
  jan_nvim = import ./nvim/default.nix { inherit pkgs; };
in
{
  imports = [
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
  
  programs.git = {
    enable = true;
    userName = "janhencic";
    userEmail = "jan@hencic.com";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 0;
          y = 0;
        };
        dynamic_padding = true;
      };
      font = {
        size = 12;
        normal = {
          family = "FiraCode Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font Mono";
        };
        italic = {
          family = "FiraCode Nerd Font Mono";
        };
      };
      colors = {
        primary = {
          background = "#272b2e";
          foreground = "#FCFCFA";
        };
        normal = {
          black = "#403E41";
          red = "#FF6188";
          green = "#A9DC76";
          yellow = "#FFD866";
          blue = "#ffba69";
          magenta = "#AB9DF2";
          cyan = "#78DCE8";
          white = "#FCFCFA";
        };
        bright = {
          black = "#727072";
          red = "#FF6188";
          green = "#A9DC76";
          yellow = "#FFD866";
          blue = "#ffba69";
          magenta = "#AB9DF2";
          cyan = "#78DCE8";
          white = "#FCFCFA";
        };
      };
      cursor = {
        underline = {};
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.bash = {
    enable = true;
  };
}
