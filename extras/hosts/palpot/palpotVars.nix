let
  username = "emanresu";
in
{
  hostVars =
  {
    configDirectory = "/home/${username}/Documents/projects/nixos";
    hostName = "palpot";

    inherit username;

    scalingFactor = 1; # 100% scaling

    touchpadName = "Libinput/1739/53227/PNP0C50:00 06CB:CFEB Touchpad";

    stateVersion = "25.05";
  };
}
