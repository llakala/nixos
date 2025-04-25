let
  username = "emanresu";
in
{
  hostVars =
  {
    configDirectory = "/home/${username}/Documents/projects/nixos";
    hostName = "temp";

    inherit username;

    scalingFactor = 2;
    fractionalScalingFactor = 1.65;

    stateVersion = "24.11";
  };
}
