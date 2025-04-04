let
  username = "emanresu";
in
{
  hostVars =
  {
    configDirectory = "/home/${username}/Documents/projects/nixos";
    hostName = "temp";

    inherit username;

    scalingFactor = 2; # 100% scaling

    stateVersion = "24.11";
  };
}
