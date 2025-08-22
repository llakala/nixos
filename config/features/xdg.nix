{ pkgs, config, ... }:

{
  hm.xdg = {
    enable = true;

    mime.enable = true;
    # mimeApps.enable = true;
  };

  hm.xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-termfilechooser
      xdg-desktop-portal-gtk
    ];
  };

  hm.xdg.portal.config = {
    common = {
      "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
    };
  };

  environment.sessionVariables.TERMCMD =
    assert config.features.terminal == "kitty";
    "kitty --class=file_chooser";

  hm.xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
    force = true;
    text = assert config.features.files == "yazi"; ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    '';
  };
}
