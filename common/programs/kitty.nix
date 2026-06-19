{ self, ... }:

{
  features.terminal = "kitty"; # Change if I ever stop using Kitty
  features.usingKittab = true; # For assertions, so we can rely on kittab's existence

  environment.systemPackages = [ self.wrappers.kittab.drv ];
}
