{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.loupe ];

  features.images = "loupe"; # Change if we ever stop using Loupe
}
