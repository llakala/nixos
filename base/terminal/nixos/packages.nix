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
    bind # Networking utils

    nodejs
    jdk

    grub2 # grub commands
    grub2_efi

    nvd # For recreating nh functions
    nix-output-monitor # NOT NOM

    ripgrep # For grep stuff
    gnumake # make command

    libsecret
    libgccjit # gcc
    efibootmgr # manage efi entries

    hwinfo
    detox # automatic file deletion

    age # Used for secrets
    ssh-to-age

    powertop # Test battery

    xorg.xeyes # Check if app is running in xwayland or wayland

    qemu-utils # Virtualization
    quickemu
  ];
}