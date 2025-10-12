{ lib, pkgs,  ... }:

{
  environment.systemPackages = lib.singleton pkgs.loupe;

  features.images = "loupe"; # Change if we ever stop using Loupe
}
