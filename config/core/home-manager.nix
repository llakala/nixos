# To find which file is causing a backup failure on rebuild, run:
# `journalctl -e --unit home-manager-emanresu.service`
# Of course, replacing `emanresu` with your username if you're not me
# The error doesn't show on rebuild when home-manager is installed as a
# NixOS module, so you have to check there.
{ config, lib, inputs, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ( # Let us use hm as shorthand for home-manager config
      lib.mkAliasOptionModule
      [ "hm" ]
      [ "home-manager" "users" config.baseVars.username ]
    )
  ];

  environment.systemPackages = with pkgs; [
    home-manager # Lets us run commands like `home-manager switch`
  ];

  hm.programs.home-manager = {
    enable = true;
  };

  hm.home = {
    username = config.baseVars.username;
    homeDirectory = config.baseVars.homeDirectory;
    stateVersion = config.hostVars.stateVersion;
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

}
