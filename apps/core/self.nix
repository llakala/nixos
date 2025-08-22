{ self, pkgs, ... }:

{
  # Custom packages from my flake, added to systemPackages for testing
  environment.systemPackages = with self.legacyPackages.${pkgs.system}; [
    evalue
    emodule
    jc
  ];
}
