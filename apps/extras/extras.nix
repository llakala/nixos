{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
    libva-utils # Check for hardware acceleration
    fd # Search filenames, used by Yazi
    w3m # w3mman gives you manpage hyperlinks
    appimage-run # Allow running appimages for when something isnt on nixpkgs
    hwinfo
    age
    libsecret
    exiftool # Check metadata
    ijq # Interactive jq

    # commands specifically for nix
    nix-output-monitor # NOT CALLED NOM
    nixfmt-rfc-style
    nix-inspect

    # Shows colors in the terminal. I packaged this!
    colo
  ];
}
