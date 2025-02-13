{ pkgs, lib, ... }:

{
  hm.xdg =
  {
    enable = true;

    mime.enable = true;
    # mimeApps.enable = true;
  };

  hm.xdg.portal =
  {
    enable = true;
    extraPortals = with pkgs;
    [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
}
