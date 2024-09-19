{
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs;
  [
    # Basic utils
    coreutils
    libgccjit # gcc
    usbutils # lsusb and friends
    bind # Networking utils
    libva-utils # Check for hardware acceleration

    # Basic commands that should be included
    zip
    unzip
    wget
    gnumake # make
    file

    # Extra commmands for personal preference
    jq
    sd # Sed alternative
    tldr
    calc # It's just slang chat
    cava # Audio display

    # Weird stuff
    appimage-run # Allow running appimages for when something isnt on nixpkgs
    powertop # Check battery drain
    xorg.xeyes
    hwinfo
    age
    libsecret

    # commands specifically for nix
    nil # Nix language server
    nvd
    nix-output-monitor # NOT CALLED NOM

    # Big kits
    nodejs
    jdk
  ];
}