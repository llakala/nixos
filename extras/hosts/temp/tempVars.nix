let
  username = "emanresu";
in {
  hostVars = {
    configDirectory = "/home/${username}/Documents/projects/nixos";
    hostName = "temp";

    inherit username;

    scalingFactor = 2;

    touchpadName = "Libinput/1160/4618/DELL09BE:00 0488:120A Touchpad";

    stateVersion = "24.11";
  };
}
