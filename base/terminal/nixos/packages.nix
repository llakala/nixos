{
  pkgs-unstable,
  pkgs,
  ...
}:


{

  environment.systemPackages =
  with pkgs;
  [
    coreutils # Tiny utils
    usbutils
    bind # Networking utils

    nodejs
    jdk
    appimage-run # Allow running appimages for when something isnt on nixpkgs

    grub2 # grub commands
    grub2_efi

    nvd # For recreating nh functions
    nix-output-monitor # NOT CALLED NOM IN NIXPKGS

    ripgrep # For grep stuff
    gnumake # make command
    clinfo # Test if opencl is installed

    libsecret
    libgccjit # gcc
    efibootmgr # manage efi entries

    hwinfo
    detox # automatic file deletion

    age # Used for secrets
    ssh-to-age

    powertop # Test battery

    xorg.xeyes # Check if app is running in xwayland or wayland

    nil # Nix language server
  ];
}