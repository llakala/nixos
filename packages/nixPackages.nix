{
  pkgs,
  pkgs-stable,
  ...
}:


{

  environment.systemPackages =
  (with pkgs-stable;
  [
    libsecret
    busybox # Tiny utils
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
    detox
  ])
  ++

  (with pkgs;
  [
    nh
  ]);
}