{ self, ... }:

{
  # Custom packages from my flake, added to systemPackages for testing
  environment.systemPackages = with self.packages; [
    evalue
    emodule
    satod
  ];
}
