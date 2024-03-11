{ pkgs, pkgs-unstable }:

let
  drata = (import ./../../drata.nix { pkgs = pkgs-unstable; stdenv = pkgs-unstable.stdenv; });
in
  with pkgs; [
    chromium
    deluge
    pavucontrol
    pkgs-unstable.slack
    pkgs-unstable.google-chrome
    postman
    drata
  ]
