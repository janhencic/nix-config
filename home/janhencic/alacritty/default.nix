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
        bold = {
          family = "FiraCode Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font Mono";
          style = "Regular";
        };
        bold_italic = {
          family = "FiraCode Nerd Font Mono";
          style = "Bold";
        };
      };

      colors = {
        primary = {
          foreground = "#c5c8c6";
          background = "#1d1f21";
        };

        normal = {
          black   = "#1d1f21";
          red     = "#cc6666";
          green   = "#b5bd68";
          yellow  = "#f0c674";
          blue    = "#81a2be";
          magenta = "#b294bb";
          cyan    = "#8abeb7";
          white   = "#c5c8c6";
        };

        bright = {
          black   = "#666666";
          red     = "#d54e53";
          green   = "#b9ca4a";
          yellow  = "#e7c547";
          blue    = "#7aa6da";
          magenta = "#c397d8";
          cyan    = "#70c0b1";
          white   = "#eaeaea";
        };

        dim = {
          black   = "#131415";
          red     = "#864343";
          green   = "#777c44";
          yellow  = "#9e824c";
          blue    = "#556a7d";
          magenta = "#75617b";
          cyan    = "#5b7d78";
          white   = "#828482";
        };

        hints = {
          start = {
            foreground = "#1d1f21";
            background = "#e9ff5e";
          };
          end = {
            foreground = "#e9ff5e";
            background = "#1d1f21";
          };
        };

        search = {
          matches = {
            foreground = "#000000";
            background = "#ffffff";
          };
          focused_match = {
            foreground = "#ffffff";
            background = "#000000";
          };
        };
      };
    };
  };
}
