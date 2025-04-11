let
  username = "emanresu";
in
{
  hostVars =
  {
    configDirectory = "/home/${username}/Documents/projects/nixos";
    hostName = "temp";

    inherit username;

    # 100% scaling
    scalingFactor = 2;

    stateVersion = "24.11";
  };
}
