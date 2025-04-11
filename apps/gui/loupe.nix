{ lib, pkgs,  ... }:

{
  environment.systemPackages = lib.singleton pkgs.loupe;

  # Change if we ever stop using Loupe
  features.images = "loupe";
}
