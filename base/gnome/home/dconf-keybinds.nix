{ ... }:

# `dconf watch /` shows what dconf changes are set live
# `gsettings list-recursively | rg "<Super>"` is also super useful for finding where a keybind is set
{
  dconf.settings =
  {
    "org/gnome/desktop/input-sources" =
    {
      xkb-options = # Make caps lock escape
      [
        "terminate:ctrl_alt_bksp"
        "caps:escape" # Caps lock --> escape
        "compose:rctrl" # Right control --> weird characters
      ];
    };



    "org/gnome/mutter/wayland/keybindings" =
    {
      restore-shortcuts = []; # Never reset shortcuts to default
    };

    "org/gnome/shell/keybindings" =
    {
      toggle-application-view = []; # Super+A is useful
      toggle-quick-settings = [ ]; # Super+S is also useful
    };

    "org/gnome/desktop/wm/keybindings" =
    {
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];


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

      custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"]; # List of custom keybindings
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
    {
      binding = "<Control><Alt>Delete";
      command = "nix run nixpkgs#resources";
      name = "Open Resources app to force quit applications";
    };


  };
}