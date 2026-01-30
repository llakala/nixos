{ self, ... }:

{
  environment.systemPackages = with self.packages; [
    evalue
    emodule
    satod
    git-repo-manager
    mathematica
  ];
}
