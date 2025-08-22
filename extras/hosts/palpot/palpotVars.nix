{ config, ... }:

{
  hostVars = {
    hostName = "palpot";
    configDirectory = "/home/${config.baseVars.username}/Documents/projects/nixos";
    stateVersion = "25.05";

    scalingFactor = 1; # 100% scaling
    touchpadName = "Libinput/1739/53227/PNP0C50:00 06CB:CFEB Touchpad";
  };
}
