{ self, ... }:

{
  environment.systemPackages = [ self.wrappers.less.drv ];
}
