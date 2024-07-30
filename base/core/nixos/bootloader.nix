{
  config,
  pkgs,
  ...
}:


{

  boot =
  {
    blacklistedKernelModules = [ ];
    extraModulePackages = with config.boot.kernelPackages; [  ];
    initrd.kernelModules = [ ];
    kernelPackages = pkgs.linuxPackages_latest;
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