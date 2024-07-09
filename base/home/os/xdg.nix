{ pkgs, ... }:


{
  xdg =
  {
    enable = true;
    mime.enable = true;


    mimeApps =
    {
      enable = true;
    };


    portal =
    {
      enable = true;
      extraPortals = with pkgs;
      [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];

      config.common.default = "gtk";
    };

  };
}