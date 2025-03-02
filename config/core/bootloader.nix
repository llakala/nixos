{ config, pkgs, lib, ... }:

{

  boot =
  {
    blacklistedKernelModules = [ ];
    extraModulePackages = with config.boot.kernelPackages; [  ];
    initrd.kernelModules = [ ];
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest; # 6.13 breaking some stuff

    kernelParams = [ "boot.shell_on_fail" ]; # Open terminal environment if we fail to boot
  };

  boot.loader =
  {
    systemd-boot.enable = true;
    systemd-boot.editor = false; # We shouldn't be editing boot params imperatively
    systemd-boot.configurationLimit = 20;

    efi.canTouchEfiVariables = true;
    timeout = lib.mkForce 1; # If not working, get rid of state via `bootctl set-default && sudo bootctl set-timeout`
  };

  boot.loader.grub.enable = lib.mkForce false; # No need to break our system accidentally


  # More unstable, but good for reporting bugs. Disable if things break
  systemd.enableStrictShellChecks = true;

}
