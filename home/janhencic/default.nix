{ pkgs, pkgs-unstable, ... }:
let
  imports = [ ./alacritty ./bash ./fzf ./git ./i3 ./tmux ];
  packages = (import ./shell_tools.nix { inherit pkgs pkgs-unstable; })
    ++ (import ./desktop_apps.nix { inherit pkgs pkgs-unstable; });
in import ./my_home_config.nix { inherit imports packages; }
