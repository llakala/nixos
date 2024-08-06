{ ... }:
{
  dconf.settings =
  {

    "org/gnome/desktop/interface" =
    {
      color-scheme = "prefer-dark";
      clock-format = "12h";
      enable-hot-corners = false;
      font-antialiasing = "rgba"; # Aliasing with lcd screen instead of grayscale
    };

    "org/gnome/desktop/wm/preferences" =
    {
      num-workspaces = 1;
      button-layout = "appmenu:minimize,close"; # Show minimize and close button for windows
      action-right-click-titlebar = "toggle-shade";
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
        "caps:escape"
      ];
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