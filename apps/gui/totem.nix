{ lib, pkgs,  ... }:

{
  environment.systemPackages = lib.singleton pkgs.totem;

  # Change if we ever stop using Totem
  features.videos = "totem";

}
