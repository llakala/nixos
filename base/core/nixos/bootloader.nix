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
    kernelPackages = pkgs.linuxPackagesFor (pkgs.linuxKernel.kernels.linux_6_10);

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