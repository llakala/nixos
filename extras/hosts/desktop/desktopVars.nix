{ config, ... }:

{
  hostVars = {
    hostName = "desktop";
    configDirectory = "/home/${config.baseVars.username}/Documents/projects/nixos";
    stateVersion = "24.05";

    scalingFactor = 1; # 100% scaling
    mouseName = "Libinput/1133/16500/Logitech G305";
  };
}
