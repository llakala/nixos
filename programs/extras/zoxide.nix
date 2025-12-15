{ self, ... }:

{
  features.fuzzyCd = "zoxide";
  environment.systemPackages = [ self.wrappers.zoxide.drv ];
}
