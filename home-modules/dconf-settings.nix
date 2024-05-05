{ ... }:
{
  dconf.settings =
  {
    "org/gnome/desktop/interface" =
    {
      color-scheme = "prefer-dark";
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

    "org/gnome/mutter" =
    {
      edge-tiling = true;
      dynamic-workspaces = false;
    };

    "org/gnome/shell" =
    {
      favorite-apps = [ "firefox.desktop" "code.desktop" "org.gnome.Terminal.desktop" "org.gnome.Nautilus.desktop"];
    };
  };
}