{ self, lib, pkgs, ... }:

let
  package = self.legacyPackages.${pkgs.system}.git-repo-manager;
in {
  environment.systemPackages = lib.singleton package;
}
