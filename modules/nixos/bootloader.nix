{ config, pkgs, ... }:
{

  boot.loader.systemd-boot.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  
  boot =
  {
    blacklistedKernelModules = [ ];
    extraModulePackages = with config.boot.kernelPackages; [  ];
    initrd.kernelModules = [ ];
    kernelPackages = pkgs.linuxPackages_latest;
  };
  boot.loader.efi =
  {
    canTouchEfiVariables = true;
  };

  boot.loader.grub =
  {
    enable = false;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
}