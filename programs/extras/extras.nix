{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Basic linux utils
    coreutils
    libgccjit # gcc
    wget
    gnumake # make
    jq
    hwinfo

    # Useful stuff
    xorg.xeyes # See if an app is running under xwayland or not
    perf
    parallel
    gparted
    ncdu # Scan folder size prettily
    tree # Show filetree for writing out in markdown
    wl-clipboard # Wayland terminal stuff
    powertop # Check battery drain
    ffmpeg
    zip
    unzip
    file
    hyperfine
    fd

    # Weird stuff
    tldr # Mini-manpages
    shortwave # Internet radio
    colo # Shows colors in the terminal
    resources
    mediawriter
    appimage-run # Allow running appimages for when something isnt on nixpkgs
    ijq # Interactive jq

    # commands specifically for nix
    nix-output-monitor # NOT CALLED NOM
    nixfmt-rfc-style
    nix-inspect
    nix-tree
  ];
}
