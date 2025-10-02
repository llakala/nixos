{ self, pkgs, ... }:

{
  # Custom packages from my flake, added to systemPackages for testing
  environment.systemPackages = with self.packages.${pkgs.system}; [
    evalue
    emodule
    jc
  ];
}
