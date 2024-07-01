{
  pkgs-unstable,
  pkgs,
  ...
}:


{

  environment.systemPackages =
  (with pkgs;
  [
    libsecret
    coreutils # Tiny utils
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
    ripgrep
    detox # automatic file deletion
    age # Used for secrets
    ssh-to-age
    qemu-utils
  ])
  ++

  (with pkgs-unstable;
  [

  ]);
}