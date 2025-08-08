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
    fractionalScalingFactor = 1.25;

    mouseName = "todo";

    stateVersion = "25.05";
  };
}
