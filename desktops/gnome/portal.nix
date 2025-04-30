{ pkgs, lib, config, ... }:

{
  hm.xdg.portal = lib.mkIf (config.features.desktop == "gnome")
  {
    configPackages = lib.singleton pkgs.xdg-desktop-portal-gnome;
  };
}
