{ self, lib, ... }:

{
  features.files = "yazi"; # Change if we ever stop using Yazi

  environment.systemPackages = [ (lib.hiPrio self.wrappers.yazi.drv) ];
}
