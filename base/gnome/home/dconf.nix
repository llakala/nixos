{ ... }:
{
  dconf.settings =
  {
    "org/gnome/shell" =
    {
      favorite-apps = # Taskbar apps
      [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "Alacritty.desktop"
        "code.desktop"
       ];
    };

    "org/gnome/desktop/interface" =
    {
      color-scheme = "prefer-dark";

      clock-format = "12h";
      clock-show-weekday = true; # Show day of the week on top bar
      clock-show-date = false; # Don't show the date


      enable-hot-corners = false;
      font-antialiasing = "rgba"; # Aliasing with lcd screen instead of grayscale

    };

    "org/gnome/desktop/wm/preferences" =
    {
      num-workspaces = 1;
      button-layout = "appmenu:minimize,close"; # Show minimize and close button for windows
      action-right-click-titlebar = "toggle-shade";
    };

    "org/gnome/mutter" =
    {
      edge-tiling = true;
      dynamic-workspaces = false;
    };


    "org/gnome/desktop/privacy" =
    {
      remove-old-temp-files = true;
      recent-files-max-age = 30;

      remove-old-trash-files = true;
      old-files-age = 30;
    };


    "org/gnome/desktop/peripherals/mouse" =
    {
      accel-profile = "flat";
    };

    "org/gnome/desktop/peripherals/touchpad" =
    {
      accel-profile = "flat";
      disable-while-typing = false;
    };



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

    "org/gnome/desktop/wm/keybindings" =
    {
      toggle-fullscreen = ["F11"];
      lower = ["<Super>Down"]; # Lower window
    };

    "org/gnome/settings-daemon/plugins/media-keys" =
    {
      screenreader = [];

      home = ["<Super>e"]; # Open file explorer
      www = ["<Super>f"]; # Open web browser
      control-center = ["<Super>i"]; # Open settings

      logout = ["<Control><Alt>BackSpace"]; # Power off

      custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"]; # List of custom keybindings
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
    {
      binding = "<Control><Alt>Delete";
      command = "nix run nixpkgs#resources";
      name = "Open Resources app to force quit applications";
    };




    "org/gtk/settings/file-chooser" =
    {
      clock-format = "12h";
    };





    "net/nokyan/Resources" =
    {
      network-bits = true; # Use mbps instead of mb/s
      graph-data-points = 100;
      sidebar-details = true;

      apps-show-gpu-memory = false;

      processes-show-user = false;
      processes-show-id = false;
    };

    "org/gnome/terminal/legacy/keybindings" =
    {
      find = "<Primary>f";
      copy = "<Primary>c";
      paste = "<Primary>v";
    };

    "org/gnome/terminal/legacy" =
    {
      new-terminal-mode = "tab";
    };


  };
}