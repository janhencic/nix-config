{ pkgs, pkgs-unstable, inputs, ... }:
let
  bash = import ./bash { inherit pkgs; };
  imports = [ ./alacritty ./fish bash ./fzf ./git ./i3 ./tmux ./nix-index inputs.nix-index-database.homeModules.nix-index  ];
  packages = (import ./shell_tools.nix { inherit pkgs pkgs-unstable; });
in import ./my_home_config.nix { inherit imports packages; }
