{ pkgs, pkgs-unstable }:

let jan_nvim = import ./nvim/default.nix { pkgs = pkgs-unstable; };

in with pkgs; [
  alacritty
  pass
  git
  sumneko-lua-language-server
  selene
  gcc
  ripgrep
  awscli
  nil
  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  jan_nvim
  tree
  tmux
  shellcheck
  jq
  htop
  nixfmt
]
