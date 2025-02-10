# Custom packages from my flake, added to systemPackages for testing
{ self, pkgs, ... }:

{
  environment.systemPackages = with self.legacyPackages.${pkgs.system};
  [
    mdpls
    evalue
    emodule
    jc
  ];
}
