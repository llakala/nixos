{ self, ... }:

{
  environment.systemPackages = [ self.wrappers.zoxide.drv ];
}
