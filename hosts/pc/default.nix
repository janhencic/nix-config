{ pkgs, inputs, pkgs-unstable, config, nil, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../common.nix
    (import ./users/janhencic { inherit pkgs config inputs pkgs-unstable nil; })
  ];

  networking.hostName = "pc";

  services.xserver = {
    # Set my preferred monitor resolution and refresh rate.
    # Taken from https://discourse.nixos.org/t/proper-way-to-configure-monitors
    displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr \
        --output HDMI-0 \
        --primary \
        --mode 3840x2160 \
        --rate 120
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
