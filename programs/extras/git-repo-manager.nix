{ self, lib, pkgs, ... }:

let
  package = self.packages.${pkgs.system}.git-repo-manager;
in {
  environment.systemPackages = lib.singleton package;
}
