{ pkgs, pkgs-unstable, ... }:

let
  stablePackages = with pkgs;
  [
    # Basic linux utils
    coreutils

    # gcc
    libgccjit

    # lsusb and friends
    usbutils

    # Networking utils
    bind
    wget

    # make
    gnumake
    jq

    # Useful stuff

    # See if an app is running under xwayland or not
    xorg.xeyes
    linuxPackages.perf
    parallel

    # Scan folder size prettily
    ncdu

    # Show filetree for writing out in markdown
    tree

    # Wayland terminal stuff
    wl-clipboard

    # Check battery drain
    powertop
    ffmpeg
    zip
    unzip
    file

    # Weird stuff

    # Mini-manpages
    tldr

    # Audio display
    cava

    # Check for hardware acceleration
    libva-utils

    # Sed alternative
    sd

    # Search filenames, used by Yazi
    fd

    # It's just slang chat
    calc

    # w3mman gives you manpage hyperlinks
    w3m

    # Allow running appimages for when something isnt on nixpkgs
    appimage-run
    hwinfo
    age
    libsecret

    # Check metadata
    exiftool

    # Interactive jq
    ijq

    # commands specifically for nix

    # Nix language server
    nil

    # NOT CALLED NOM
    nix-output-monitor
    nixfmt-rfc-style
    nix-inspect
  ];

  unstablePackages = with pkgs-unstable;
  [
    colo
  ];

in
{
  environment.systemPackages = stablePackages ++ unstablePackages;
}
