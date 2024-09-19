{ config, pkgs, lib, ... }:


{

  boot =
  {
    blacklistedKernelModules = [ ];
    extraModulePackages = with config.boot.kernelPackages; [  ];
    initrd.kernelModules = [ ];
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    kernelParams = [ "boot.shell_on_fail" ]; # Open terminal environment if we fail to boot
  };

  boot.loader =
  {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.loader.grub =
  {
    enable = false;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
}