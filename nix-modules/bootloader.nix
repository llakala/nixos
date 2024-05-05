{ config, pkgs, ... }:
{


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
    efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
  };

  boot.loader.grub =
  {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
}