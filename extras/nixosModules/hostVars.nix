{ lib, ... }:

{
  options.hostVars = {
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "The hostname for the current host.";
      default = null;
    };

    configDirectory = lib.mkOption {
      type = lib.types.str;
      description = "The directory of the local nixos configuration.";
      default = null;
    };

    scalingFactor = lib.mkOption {
      type = lib.types.int;
      description = "The scaling factor for the desktop. A scalingFactor of 1 --> 100% scaling.";
      default = null;
    };

    touchpadName = lib.mkOption {
      type = with lib.types; nullOr str;
      # Check this for KDE with `nix run github:nix-community/plasma-manager`
      description = "The internal name of your touchpad. If null, assumes your host doesn't have a touchpad.";
      default = null;
    };

    mouseName = lib.mkOption {
      type = with lib.types; nullOr str;
      # Check this for KDE with `nix run github:nix-community/plasma-manager`
      description = "The internal name of your mouse. If null, assumes your host doesn't have a mouse.";
      default = null;
    };

    stateVersion = lib.mkOption {
      type = lib.types.str;
      description = "The version cycle of NixOS during which this host was installed.";
      example = "24.05";
      default = null;
    };
  };
}
