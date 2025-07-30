{ pkgs, lib, config, ... }:

{
  hm.xdg.portal = lib.mkIf (config.features.desktop == "kde")
  {
    configPackages = lib.singleton pkgs.kdePackages.xdg-desktop-portal-kde;
  };
}
