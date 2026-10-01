{ pkgs, self, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
      self.wrappers.termfilechooser.result
    ];
    config.common = {
      "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
    };
  };
}
