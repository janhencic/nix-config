{ pkgs, pkgs-unstable }:

let
  google-chrome = (pkgs-unstable.google-chrome.override {
    commandLineArgs =
      [ "--enable-features=UseOzonePlatform" "--ozone-platform=wayland" ];
  });
in with pkgs; [
  chromium
  deluge
  pavucontrol
  pkgs-unstable.slack
  google-chrome

  pkgs-unstable.postman
]
