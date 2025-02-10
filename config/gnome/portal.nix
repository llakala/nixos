{ lib, pkgs, ... }:
{
  hm.xdg.portal =
  {
    extraPortals = lib.singleton pkgs.xdg-desktop-portal-gnome;
    config.common.default = "gnome";
  };

}
