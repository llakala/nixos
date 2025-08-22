let
  username = "emanresu";
in {
  hostVars = {
    configDirectory = "/home/${username}/Documents/projects/nixos";
    hostName = "desktop";

    inherit username;

    scalingFactor = 1; # 100% scaling

    mouseName = "Libinput/1133/16500/Logitech G305";

    stateVersion = "24.05";
  };
}
