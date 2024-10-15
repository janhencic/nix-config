{ config, pkgs, pkgs-unstable, ... }:

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

  hardware.nvidia.modesetting.enable = true;

  hardware.opengl.enable = true;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "555.58.02";
    sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
    sha256_aarch64 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
    openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
    settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
    persistencedSha256 = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
  };

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

  boot.kernelPackages = pkgs.linuxPackages_6_10;

  hardware.bluetooth.enable = true;

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      desktopManager = { xterm.enable = false; };
    };

    libinput.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sessionPackages = [ pkgs.hyprland ];
    displayManager.defaultSession = "hyprland";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

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
}
