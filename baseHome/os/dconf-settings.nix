{ ... }:
{
  dconf.settings =
  {

    "org/gnome/evolution-data-server/calendar" =
    {
      notify-with-tray = true;
    };

    "org/gnome/desktop/interface" =
    {
      color-scheme = "prefer-dark";
      clock-format = "12h";
      enable-hot-corners = false;
    };

    "org/gnome/desktop/wm/preferences" =
    {
      num-workspaces = 1;
    };

    "org/gnome/desktop/peripherals/mouse" =
    {
      accel-profile = "flat";
    };

    "org/gnome/desktop/peripherals/touchpad" =
    {
      disable-while-typing = false;
    };

    "org/gnome/mutter" =
    {
      edge-tiling = true;
      dynamic-workspaces = false;
    };

    "org/gnome/shell" =
    {
      favorite-apps =
      [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Terminal.desktop"
        "code.desktop"
       ];
    };

    "org/gtk/settings/file-chooser" =
    {
      clock-format = "12h";
    };

    "org/gtk/gtk4/settings/file-chooser" =
    {
      show-hidden = true;
    };
  };
}