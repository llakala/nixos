{ pkgs, ... }:

let
  gnomeExtensions = with pkgs.gnomeExtensions;
  [
    dash-to-dock
    clipboard-indicator
    just-perfection
    alphabetical-app-grid

    # When tiling one app, suggest another app to tile
    tiling-assistant

    # Put things on the top right closer together
    status-area-horizontal-spacing

    # Airplane mode won't auto enable
    sane-airplane-mode
  ];

in
{
  environment.systemPackages = gnomeExtensions;

  hm.dconf.settings =
  {

    "org/gnome/shell" =
    {
      disabled-extensions = [];

      # Hopefully enables all extensions after reboot
      disable-user-extensions = false;

      # Enable all gnomeExtensions
      enabled-extensions = map (extension: extension.extensionUuid) gnomeExtensions;
    };


    "org/gnome/shell/extensions/dash-to-dock" =
    {
      dock-fixed = true;

      custom-theme-shrink = true;
      apply-custom-theme = true;

      show-trash = false;
      show-show-apps-button = false;
      show-mounts = false;
      dash-max-iconsize = 56;
    };

    "org/gnome/shell/extensions/clipboard-indicator" =
    {
      # Move to top of the list when selected
      move-item-first = true;
      paste-button = false;

      enable-keybindings = false;
      history-size = 150;
    };

    "org/gnome/shell/extensions/just-perfection" =
    {
      panel = false;
      panel-in-overview = true;
      calendar = false;

      # Just make window appear when it's done with a task
      window-demands-attention-focus = true;


      # No delay with alt-tab
      switcher-popup-delay = true;

      # Start on overview when rebooting
      startup-status = 1;
    };

    "org/gnome/shell/extensions/tiling-assistant" =
    {
      # Let us use Super+Down
      restore-window = [];

      tile-left-half = ["<Super>a" "<Super>Left"];
      tile-right-half = ["<Super>d" "<Super>Right"];
      tile-top-half = ["<Super>w"];
      tile-bottom-half = ["<Super>s"];

      enable-advanced-experimental-features = true;

      # Indirectly disables edge tiling via the GUI, so we only do it via keybinds
      default-move-mode = 2;
    };

    "org/gnome/shell/extensions/sane-airplane-mode" =
    {
      enable-airplane-mode = false;

      # Misleading: actually means when turning off airplane mode, bluetooth doesn't go on
      enable-bluetooth = false;
    };
  };
}
