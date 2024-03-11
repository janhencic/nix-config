{ pkgs, inputs, config, pkgs-unstable, nil, ... }:
{
  users.users.janhencic = {
    isNormalUser = true;
    initialPassword = "123";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
    packages = with pkgs; [
      home-manager
    ];

  };

  home-manager.users.janhencic = (import ./home { inherit pkgs inputs config pkgs-unstable nil; });
}
