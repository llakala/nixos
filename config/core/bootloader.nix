{ config, pkgs, lib, ... }:

{
  boot = {
    blacklistedKernelModules = [ ];
    extraModulePackages = with config.boot.kernelPackages; [  ];
    initrd.kernelModules = [ ];
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    kernelParams = [ "boot.shell_on_fail" ]; # Open terminal environment if we fail to boot
  };

  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.editor = false; # We shouldn't be editing boot params imperatively
    systemd-boot.configurationLimit = 20;

    efi.canTouchEfiVariables = true;

    # Setting this super high to fix issues where windows is autoselected, and
    # if chosen, it bricks my install
    # If not working, get rid of state via `bootctl set-default && sudo bootctl set-timeout`
    timeout = lib.mkForce 9999;
  };

  boot.loader.grub.enable = lib.mkForce false; # No need to break our system accidentally

  # More unstable, but good for reporting bugs. Disable if things break
  systemd.enableStrictShellChecks = true;
}
