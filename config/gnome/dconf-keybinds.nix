# `dconf watch /` shows what dconf changes are set live
# `gsettings list-recursively | rg "<Super>"` is also super useful for finding where a keybind is set
{
  hm.dconf.settings =
  {
    "org/gnome/mutter/wayland/keybindings" =
    {
      # Never reset shortcuts to default
      restore-shortcuts = [];
    };

    "org/gnome/shell/keybindings" =
    {
      # Super+A is useful
      toggle-application-view = [];

      # Super+S is also useful
      toggle-quick-settings = [ ];
    };

    # Make apps immediately appear in alt tab menu
    "org/gnome/desktop/wm/keybindings" =
    {
      # Legacy alt-tab menu
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];

      # Previously Alt+Space
      activate-window-menu = [];


      toggle-fullscreen = ["F11"];
    };



    "org/gnome/settings-daemon/plugins/media-keys" =
    {
      screenreader = [];

      # Open file explorer
      home = ["<Super>e"];

      # Open web browser
      www = ["<Super>f"];

      # Open settings
      control-center = ["<Super>i"];
      search = ["<Super>space"];

      # Power off
      logout = ["<Control><Alt>BackSpace"];
    };


  };
}
