{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Basic utils
    ffmpeg
    file
    gnumake
    ncdu
    tree # Show filetree for writing out in markdown
    unzip
    wget
    zip

    # Useful stuff
    asciinema_3
    fd
    gparted
    hyperfine
    jq
    parallel
    perf
    powertop # Check battery drain
    wl-clipboard
    xorg.xeyes # See if an app is running under xwayland or not

    # Weird stuff
    colo # Shows colors in the terminal
    ijq # Interactive jq
    mediawriter
    resources
    shortwave # Internet radio
    tldr # Mini-manpages

    # commands specifically for nix
    nixfmt-rfc-style
    nix-inspect
    nix-output-monitor # NOT CALLED NOM
    nix-tree
  ];
}
