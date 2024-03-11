{ pkgs, stdenv }:

stdenv.mkDerivation rec {
  pname = "drata-agent";
  version = "3.4.1";
  name = "${pname}-${version}";
  src = pkgs.fetchurl {
    url = "https://cdn.drata.com/agent/dist/linux/drata-agent-3.4.1.deb";
    sha256 = "sha256-DVxsTAiDVNbGQZTvWZkvcu6UxB9oWTXh1AmqE7NLqBs=";
  };
  unpackCmd = "dpkg-deb -x $src ./${pname}-${version}";
  dontBuild = true;

  nativeBuildInputs = with pkgs; [
    dpkg
    autoPatchelfHook
    makeWrapper
    copyDesktopItems
  ];

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "${pname}";
      desktopName = "${pname}";
      exec = "${pname}";
      icon = "${pname}";
      categories = [ "Office" ];
    })
  ];

  buildInputs = with pkgs; [
    alsa-lib
    cups
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXtst
    mesa
    nss
    gtk3
    libva
    gsettings-desktop-schemas
    libglibutil
    glib
  ];

  runtimeDependenciesPath = with pkgs;
    lib.makeLibraryPath [
      stdenv.cc.cc
      libglvnd
      openssl
      udev
      alsa-lib
      libpulseaudio
      # libva
      ffmpeg
      xorg.libX11
      xorg.libXcursor
      xorg.libXi
      xorg.libXrandr
      gsettings-desktop-schemas
      libglibutil
      glib
    ];

  postPatch = "";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -r opt $out/opt
    cp -r usr/share $out/share
    chmod +x "$out/opt/Drata Agent/drata-agent"
    ln -s "$out/opt/Drata Agent/drata-agent" $out/bin/drata-agent
    wrapProgram $out/bin/drata-agent \
      --prefix LD_LIBRARY_PATH : "$runtimeDependenciesPath"
    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Collects data for certification";
    homepage = "https://drata.com";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}
