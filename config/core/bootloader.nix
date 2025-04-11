{ config, pkgs, lib, ... }:

{

  boot =
  {
    blacklistedKernelModules = [ ];
    extraModulePackages = with config.boot.kernelPackages; [  ];
    initrd.kernelModules = [ ];

    # 6.13 breaking some stuff on stable, see https://github.com/NixOS/nixpkgs/issues/375730#issuecomment-2625157971
    kernelPackages = lib.mkDefault pkgs.linuxPackages_6_12;

    # Open terminal environment if we fail to boot
    kernelParams = [ "boot.shell_on_fail" ];
  };

  boot.loader =
  {
    systemd-boot.enable = true;

    # We shouldn't be editing boot params imperatively
    systemd-boot.editor = false;
    systemd-boot.configurationLimit = 20;

    efi.canTouchEfiVariables = true;

    # If not working, get rid of state via `bootctl set-default && sudo bootctl set-timeout`
    timeout = lib.mkForce 1;
  };

  # No need to break our system accidentally
  boot.loader.grub.enable = lib.mkForce false;


  # More unstable, but good for reporting bugs. Disable if things break
  systemd.enableStrictShellChecks = true;

}
