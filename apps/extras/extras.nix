{ pkgs, pkgs-unstable, ... }:

let
  stablePackages = with pkgs;
  [
    # Basic linux utils
    coreutils
    libgccjit # gcc
    usbutils # lsusb and friends
    bind # Networking utils
    wget
    gnumake # make
    jq

    # Useful stuff
    xorg.xeyes # See if an app is running under xwayland or not
    linuxPackages.perf
    parallel
    ncdu # Scan folder size prettily
    tree # Show filetree for writing out in markdown
    wl-clipboard # Wayland terminal stuff
    powertop # Check battery drain
    ffmpeg
    zip
    unzip
    file

    # Weird stuff
    tldr # Mini-manpages
    cava # Audio display
    libva-utils # Check for hardware acceleration
    sd # Sed alternative
    fd # Search filenames, used by Yazi
    calc # It's just slang chat
    w3m # w3mman gives you manpage hyperlinks
    appimage-run # Allow running appimages for when something isnt on nixpkgs
    hwinfo
    age
    libsecret
    exiftool # Check metadata
    ijq # Interactive jq

    # commands specifically for nix
    nil # Nix language server
    nix-output-monitor # NOT CALLED NOM
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
