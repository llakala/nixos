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

    # Basic commands that should be included
    zip
    unzip
    wget
    gnumake # make
    file
    tldr
    calc # It's just slang chat

    # Extra commmands for personal preference
    jq
    ripgrep
    sd # Sed alternative

    # Weird stuff
    appimage-run # Allow running appimages for when something isnt on nixpkgs
    powertop # Check battery drain
    xorg.xeyes
    hwinfo
    age
    libsecret
    cava # Audio display

    # commands specifically for nix
    nil # Nix language server
    nvd
    nix-output-monitor # NOT CALLED NOM

    # Big kits
    nodejs
    jdk
  ];
}