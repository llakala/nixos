{ config, pkgs, ...}:

{

  hardware.nvidia =
  {
    modesetting.enable = true;

    powerManagement.enable = false;

    powerManagement.finegrained = false;

    open = false;
    nvidiaSettings = true;
  };

  services.xserver.videoDrivers = ["nvidia"]; # Use proprietary drivers
}
