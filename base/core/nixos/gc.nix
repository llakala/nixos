{
  hostVars,
  pkgs,
  inputs,
  lib,
  vars,
  ...
}:

{
  nix.settings =
  {
    auto-optimise-store = true;
  };

  boot.loader.systemd-boot.configurationLimit = 20; # Only keep 20 

  nix.gc =
  {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}