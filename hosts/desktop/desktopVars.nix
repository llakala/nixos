let
  username = "emanresu";
in
{
  hostVars =
  {
    configDirectory = "/home/${username}/Documents/projects/nixos";
    hostName = "desktop";

    inherit username;

    scalingFactor = 1; # 100% scaling

    stateVersion = "24.05";
  };
}
