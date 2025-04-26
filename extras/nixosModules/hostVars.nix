{ lib, config, ... }:

let
  cfg = config.hostVars;
in
{
  options.hostVars =
  {
    configDirectory = lib.mkOption
    {
      type = lib.types.str;
      description = "The directory of the local nixos configuration.";
      default = null;
    };

    hostName = lib.mkOption
    {
      type = lib.types.str;
      description = "The hostname for the current host.";
      default = null;
    };

    username = lib.mkOption
    {
      type = lib.types.str;
      description = "The username for the current host.";
      default = null;
    };

    homeDirectory = lib.mkOption
    {
      type = lib.types.str;
      description = "The directory for the user's folders. This should only be set if it's in a non-default location.";
      default = "/home/${cfg.username}";
    };

    scalingFactor = lib.mkOption
    {
      type = lib.types.int;
      description = "The scaling factor for the desktop. A scalingFactor of 1 --> 100% scaling.";
      default = null;
    };

    fractionalScalingFactor = lib.mkOption
    {
      type = lib.types.float;
      description =
        "The scaling factor for the desktop, if the desktop supports fractional scaling (basically, if it's not Gnome)";
      default = null;
    };

    stateVersion = lib.mkOption
    {
      type = lib.types.str;
      description = "The version cycle of NixOS during which this host was installed.";
      example = "24.05";
      default = null;
    };
  };
}
