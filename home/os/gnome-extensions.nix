{ ... }:

{

  dconf.settings =
  {
    "org/gnome/shell" =
    {
      disable-user-extensions = false;

      enabled-extensions =
      [
        "dash-to-dock@micxgx.gmail.com"
        "clipboard-indicator@tudmotu.com"
        "just-perfection-desktop@just-perfection"
      ];

    };

    "org/gnome/shell/extensions/dash-to-dock" =
    {
      autohide-in-fullscreen = true;
      intellihide-mode = "ALWAYS_ON_TOP";
      hide-delay = 0.15;
      show-delay = 0.15;
      show-trash = false;
      show-show-apps-button = false;
      show-mounts = false;
      dash-max-iconisze = 56;
    };

    "org/gnome/shell/extensions/clipboard-indicator" =
    {
      enable-keybindings = false;
      history-size = 30;
    };

    "org/gnome/shell/extensions/just-perfection" =
    {
      panel = false;
      "panel-in-overview" = true;
      "window-demands-attention-focus" = true;
      "switcher-popup-delay" = false;
      "startup-status" = 0;
    };
  };
}