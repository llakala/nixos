# Custom packages from my flake, added to systemPackages for testing
{ self, pkgs, ... }:
{
  environment.systemPackages = with self.packages.${pkgs.system};
  [
    mdpls
    evalue
    emodule
    efunc
    jv
  ];
}