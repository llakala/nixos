{
  hostVars =
  {
    configDirectory = "/etc/nixos";
    hostName = "temp";
    username = "nixos"; # We'll use the default user rather than creating a new one

    scalingFactor = 1; # 100% scaling

    stateVersion = "24.11";
  };
}
