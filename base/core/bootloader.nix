{ config, pkgs-unstable, lib, ... }:


{

  boot =
  {
    blacklistedKernelModules = [ ];
    extraModulePackages = with config.boot.kernelPackages; [  ];
    initrd.kernelModules = [ ];
    kernelPackages = lib.mkDefault pkgs-unstable.linuxPackages_latest;

    kernelParams = [ "boot.shell_on_fail" ]; # Open terminal environment if we fail to boot
  };

  boot.loader =
  {
    systemd-boot.enable = true;
    systemd-boot.editor = false; # We shouldn't be editing boot params imperatively
    systemd-boot.configurationLimit = 20;

    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.loader.grub.enable = lib.mkForce false; # No need to break our system accidentally

}