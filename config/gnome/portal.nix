{ pkgs, ... }:

{
  hm.xdg.portal =
  {
    extraPortals = with pkgs;
    [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];

    config.common.default = ["gnome" "gtk" ];
  };

}
