{ self, ... }:

{
  features.files = "yazi"; # Change if we ever stop using Yazi
  environment.systemPackages = [ self.wrappers.yazi.drv ];
}
