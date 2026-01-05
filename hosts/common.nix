{ config, pkgs, pkgs-unstable, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";

  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];

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
  # sound.enable = true;
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
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  hardware.nvidia.open = false;

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

  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "50-zsa";
      text = ''
        # Rules for Oryx web flashing and live training
        KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
        KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

        # Legacy rules for live training over webusb (Not needed for firmware v21+)
          # Rule for all ZSA keyboards
          SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
          # Rule for the Moonlander
          SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
          # Rule for the Ergodox EZ
          SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
          # Rule for the Planck EZ
          SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

        # Wally Flashing rules for the Ergodox EZ
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
        KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

        # Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
        # Keymapp Flashing rules for the Voyager
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
      '';

      destination = "/etc/udev/rules.d/50-zsa.rules";
    })
  ];
}
