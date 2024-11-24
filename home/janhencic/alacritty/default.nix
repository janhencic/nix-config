{
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "alacritty-direct";
      };
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
        bold = { family = "FiraCode Nerd Font Mono"; };
        italic = { family = "FiraCode Nerd Font Mono"; };
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
    };
  };
}
