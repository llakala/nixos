{ lib, pkgs,  ... }:

{
  environment.systemPackages = lib.singleton pkgs.totem;

  features.videos = "totem"; # Change if we ever stop using Totem

}
