# To find baseVars file is causing a backup failure on rebuild, run:
# `journalctl -e --unit home-manager-emanresu.service`
# Of course, replacing `emanresu` with your username if you're not me
# The error doesn't show on rebuild when home-manager is installed as a
# NixOS module, so you have to check there.
{ self, lib, ... }:

{
  imports = [
    (import "${self.sources.home-manager}/nixos")

    # Let us use hm as shorthand for home-manager config
    (
      lib.mkAliasOptionModule
      [ "hm" ]
      [ "home-manager" "users" self.baseVars.username ]
    )
  ];

  hm.home = {
    username = self.baseVars.username;
    homeDirectory = self.baseVars.homeDirectory;
    stateVersion = self.hostVars.stateVersion;
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

}
