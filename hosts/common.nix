{ config, pkgs, pkgs-unstable, ... }:

let
  ExecStart = pkgs.writeShellScriptBin "exec-start" ''
    ${pkgs.iproute}/bin/ip tuntap add dev tap0 mode tap user ${config.users.users.janhencic.name}
    ${pkgs.iproute}/bin/ip link set tap0 up
    ${pkgs.iproute}/bin/ip link set tap0 master br0
  '';
in
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";

  networking = {
    # Define the bridge
    # bridges.br0.interfaces = [ "eno1" ];
    # useNetworkd = true;  # Ensure networkd is used for managing networks
    # interfaces.eno1.useDHCP = false;  # Disable DHCP on the physical interface
    # interfaces.br0.useDHCP = true;  # Enable DHCP on the bridge interface
    networkmanager.enable = true;
  };

  # # Define a systemd service for the TAP interface
  # systemd.services.tap0 = {
  #   description = "Configure TAP interface for QEMU";
  #   after = [ "network.target" ];
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${ExecStart}/bin/exec-start";
  #     # ExecStop = "${ExecStop}/bin/exec-stop";
  #     RemainAfterExit = true;
  #     Restart = "on-failure";
  #   };
  # };

  networking.firewall.allowedTCPPorts = [ 2375 2376 ]; # Open port 5000 for the registry

  time.timeZone = "Europe/Ljubljana";

  i18n.defaultLocale = "en_US.UTF-8";

  environment.pathsToLink = [ "/libexec" ];

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [ 
    picom 
    pinentry-curses
    # Needed for hyprland screen sharing
    pkgs-unstable.pipewire
    pkgs-unstable.wireplumber
    pkgs-unstable.xdg-desktop-portal-hyprland
    # xdph
    pkgs-unstable.libcamera
    pkgs-unstable.xdg-desktop-portal
    pkgs-unstable.grim
    pkgs-unstable.slurp
  ];

  nixpkgs.config.allowUnfree = true;

  programs.mosh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;

  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  hardware.nvidia.prime = {
    sync.enable = true;

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";
  };

  environment.sessionVariables = {
    XDG_CONFIG_HOME = "\${HOME}/.config";
    TERM = "xterm-256color";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  # https://github.com/NixOS/nixpkgs/issues/221035
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.bluetooth.enable = true;

  services.xserver = {
    enable = true;
    desktopManager = { xterm.enable = false; };

    libinput.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sessionPackages = [ pkgs.hyprland ];
    displayManager.defaultSession = "hyprland";
  };
  programs.hyprland.enable = true;

  virtualisation.docker = {
    enable = true;
  };

  virtualisation.docker.daemon.settings = {
    hosts = [ "tcp://0.0.0.0:2375" "tcp://0.0.0.0:2376" "unix:///var/run/docker.sock" ];
    insecure-registries = [
      "127.0.0.1:5000"
    ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  }; 

  # virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "janhencic" ];

  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11_beta ];
}
