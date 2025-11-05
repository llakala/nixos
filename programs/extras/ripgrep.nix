{ self, ... }:

{
  environment.systemPackages = [ self.wrappers.ripgrep.drv ];
}
