{ pkgs, hostVars, ... }:


{
  xdg =
  {
    enable = true;
    mime.enable = true;

    mimeApps.enable = true;
  };

  xdg.portal =
  {
    enable = true;
    extraPortals = with pkgs;
    [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      xdg-desktop-portal-hyprland
    ];

    config.common.default = "gnome";
  };
}