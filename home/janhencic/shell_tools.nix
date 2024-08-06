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
  pkg-config

  just
  pkgs-unstable.protobuf

  pkgs-unstable.cargo
  pkgs-unstable.rust-analyzer
  pkgs-unstable.rustc
  pkgs-unstable.rustfmt

  # pkgs-unstable.rustup

  pkgs-unstable.natscli

  pkgs-unstable.skaffold
  pkgs-unstable.kubernetes-helm
  pkgs-unstable.minikube
  pkgs-unstable.kubectl

  pkgs-unstable.nodejs
  pkgs-unstable.typescript

  pkgs-unstable.postgresql_jit
]
