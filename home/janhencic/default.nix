{ pkgs, pkgs-unstable, inputs, ... }:
let
  tmux = import ./tmux { inherit pkgs; };
  bash = import ./bash { inherit pkgs; };

  imports = [ ./alacritty ./fish bash ./fzf ./git ./hyprland tmux ./nix-index inputs.nix-index-database.homeModules.nix-index ];
  packages = (import ./shell_tools.nix { inherit pkgs pkgs-unstable; })
    ++ (import ./desktop_apps.nix { inherit pkgs pkgs-unstable; });
in import ./my_home_config.nix { inherit imports packages; }
