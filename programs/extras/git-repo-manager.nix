{ self, ... }:

let
  package = self.packages.git-repo-manager;
in {
  environment.systemPackages = [ package ];
}
