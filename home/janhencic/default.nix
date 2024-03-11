{ config, pkgs, inputs, pkgs-unstable, nil, ... }:
let
  shell_tools = import ./shell_tools.nix { inherit pkgs pkgs-unstable; };
  destkop_apps = import ./desktop_apps.nix { inherit pkgs pkgs-unstable; };
in
{
  imports = [
    ./alacritty.nix
    ./bash
    ./fzf.nix
    ./git.nix
    ./i3
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

    packages = shell_tools ++ destkop_apps;
  };
}
