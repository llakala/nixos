{ lib, pkgs,  ... }:

{
  environment.systemPackages = lib.singleton pkgs.totem;

  features.videoViewer = "totem"; # Change if we ever stop using Totem

}
