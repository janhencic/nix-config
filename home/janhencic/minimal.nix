{ config, pkgs, pkgs-unstable, nil, ... }:
let
  shell_tools = import ./shell_tools.nix { inherit pkgs pkgs-unstable; };
in
{
  imports = [
    ./bash
    ./fzf.nix
    ./git.nix
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

    packages = shell_tools;
  };
}
