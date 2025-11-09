{ pkgs,  ... }:

{
  environment.systemPackages = [ pkgs.totem ];
  features.videos = "totem"; # Change if we ever stop using Totem
}
