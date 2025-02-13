{ lib, pkgs,  ... }:

{
  environment.systemPackages = lib.singleton pkgs.loupe;

  features.imageViewer = "loupe"; # Change if we ever stop using Loupe
}
