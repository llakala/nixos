{ self, ... }:

{
  environment.systemPackages = [ self.packages.git-repo-manager ];
}
