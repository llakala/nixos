{
  hostVars =
  {
    configDirectory = "/etc/nixos";
    hostName = "temp";

    # We'll use the default user rather than creating a new one
    username = "nixos";

    # 100% scaling
    scalingFactor = 1;

    stateVersion = "24.11";
  };
}
