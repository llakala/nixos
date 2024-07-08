{
  pkgs-unstable,
  pkgs,
  ...
}:


{

  environment.systemPackages =
  with pkgs;
  [
    git
    coreutils # Tiny utils

    libsecret
    libgccjit # gcc
    linuxKernel.packages.linux_xanmod_stable.system76 # dkms command
    gnumake # make command
    nodejs
    git
    efibootmgr # manage efi entries

    grub2 # grub commands
    grub2_efi

    jdk22
    hwinfo
    ripgrep # For grep stuff
    detox # automatic file deletion

    age # Used for secrets
    ssh-to-age

    qemu-utils # Virtualization

    nvd # For recreating nh functions
    nix-output-monitor

    powertop # Test battery
  ];
}