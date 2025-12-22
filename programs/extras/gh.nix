{ self, ... }:

{
  environment.systemPackages = [ self.wrappers.gh.drv ];
}
