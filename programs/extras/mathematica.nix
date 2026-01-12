{ self, ... }:

{
  environment.systemPackages = [
    self.packages.mathematica
  ];
}
