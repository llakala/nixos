{ self, lib, ... }:

let
  package = self.packages.git-repo-manager;
in {
  environment.systemPackages = lib.singleton package;
}
