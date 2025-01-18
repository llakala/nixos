# `dconf watch /` shows what dconf changes are set live
# `gsettings list-recursively | rg "<Super>"` is also super useful for finding where a keybind is set
{
  hm.dconf.settings =
  {
    "org/gnome/mutter/wayland/keybindings" =
    {
      restore-shortcuts = []; # Never reset shortcuts to default
    };

    "org/gnome/shell/keybindings" =
    {
      toggle-application-view = []; # Super+A is useful
      toggle-quick-settings = [ ]; # Super+S is also useful
    };

    # Make apps immediately appear in alt tab menu
    "org/gnome/desktop/wm/keybindings" =
    {
      switch-applications = [ "<Super>Tab" ]; # Legacy alt-tab menu
      switch-applications-backward = [ "<Shift><Super>Tab" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      activate-window-menu = []; # Previously Alt+Space


      toggle-fullscreen = ["F11"];
    };



    "org/gnome/settings-daemon/plugins/media-keys" =
    {
      screenreader = [];

      home = ["<Super>e"]; # Open file explorer
      www = ["<Super>f"]; # Open web browser
      control-center = ["<Super>i"]; # Open settings
      search = ["<Super>space"];

      logout = ["<Control><Alt>BackSpace"]; # Power off
    };


  };
}
