{ pkgs, pkgs-unstable }:

with pkgs; [
  chromium
  deluge
  pavucontrol
  pkgs-unstable.slack
  pkgs-unstable.google-chrome
  pkgs-unstable.postman
]
