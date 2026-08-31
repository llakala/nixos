{ self, ... }:

{
  environment.systemPackages = with self.packages; [
    evalue
    emodule
    satod
    mathematica
  ];
}
