{ pkgs, ... }:

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
    ncdu # Scan folder size prettily
    tree # Show filetree for writing out in markdown
    w3m # w3mman gives you manpage hyperlinks

    # Weird stuff
    appimage-run # Allow running appimages for when something isnt on nixpkgs
    powertop # Check battery drain
    xorg.xeyes # See if an app is running under xwayland or not
    hwinfo
    age
    libsecret
    ffmpeg
    exiftool
    wl-clipboard # Wayland terminal stuff
    ijq # Interactive jq

    # commands specifically for nix
    nil # Nix language server
    nix-output-monitor # NOT CALLED NOM
    nixfmt-rfc-style
    nix-inspect

    # Big kits
    nodejs
    typescript
  ];
}
