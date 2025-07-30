{
  hostVars =
  {
    configDirectory = "/etc/nixos";
    hostName = "temp";
    username = "nixos"; # We'll use the default user rather than creating a new one

    scalingFactor = 1;
    fractionalScalingFactor = 1.25;

    stateVersion = "24.11";
  };
}
