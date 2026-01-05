{ pkgs, pkgs-unstable }:

let jan_nvim = import ./nvim/default.nix { pkgs = pkgs-unstable; };

in with pkgs; [
  alacritty
  pass
  git
  lua-language-server
  selene
  gcc
  ripgrep
  awscli
  nil
  pkgs.nerd-fonts.fira-code
  pkgs.nerd-fonts.droid-sans-mono
  jan_nvim
  tree
  tmux
  shellcheck
  jq
  htop
  # TODO: Consider switching to 'nixfmt-rfc-style'
  nixfmt-classic
  pkg-config

  just
  pkgs-unstable.protobuf

  pkgs-unstable.natscli

  pkgs-unstable.skaffold
  pkgs-unstable.kubernetes-helm
  # pkgs-unstable.minikube
  # pkgs-unstable.kubectl

  # pkgs-unstable.nodejs
  pkgs-unstable.typescript

  pkgs-unstable.postgresql_jit

  (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])

  pkgs-unstable.pgrok
  pkgs-unstable.acpi
  pkgs-unstable.fish-lsp
  pkgs.tvbeat-ssh
]
