{ pkgs, pkgs-unstable }:

let
  drata = (import ./drata {
    pkgs = pkgs-unstable;
    stdenv = pkgs-unstable.stdenv;
  });
in with pkgs; [
  chromium
  deluge
  pavucontrol
  pkgs-unstable.slack
  pkgs-unstable.google-chrome
  drata
  pkgs-unstable.postman
]
