{ pkgs, ... }: 
let 
  look_and_feel = (builtins.readFile ./look_and_feel.conf);
  keybindings = (builtins.readFile ./keybindings.conf);
  input = (builtins.readFile ./input.conf);
  monitors = (builtins.readFile ./monitors.conf);
  env_vars = (builtins.readFile ./env_vars.conf);
in
{
    wayland = {
      windowManager.hyprland = {
        enable = true;
        extraConfig = ''
          # This is my Hyprland config, refer to the wiki for more information
          # https://wiki.hyprland.org/Configuring/Configuring-Hyprland/

          source ${look_and_feel}
          source ${keybindings}
          source ${input}
          source ${monitors}
          source ${env_vars}
        '';

        package = pkgs.hyprland;
        xwayland.enable = true;
        systemd.enable = true;
      };
    };

    home.packages = with pkgs; [ rofi ];
}
