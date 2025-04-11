let
  username = "emanresu";
in
{
  hostVars =
  {
    configDirectory = "/home/${username}/Documents/projects/nixos";
    hostName = "desktop";

    inherit username;

    # 100% scaling
    scalingFactor = 1;

    stateVersion = "24.05";
  };
}
