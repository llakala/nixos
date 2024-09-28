{ pkgs, config, lib, ... }:


{
  hm =
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

    home.file."${config.hostVars.homeDirectory}/.config/mimeapps.list".force = lib.mkForce true; # Delete backup for mimeApps since backups are done idiotically
  };
}