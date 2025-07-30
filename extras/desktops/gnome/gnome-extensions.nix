{ pkgs, ... }:

let
  gnomeExtensions = with pkgs.gnomeExtensions;
  [
    dash-to-dock
    clipboard-indicator
    just-perfection
    alphabetical-app-grid
    tiling-assistant # When tiling one app, suggest another app to tile
    status-area-horizontal-spacing # Put things on the top right closer together
    sane-airplane-mode # Airplane mode won't auto enable
  ];

in
{
  environment.systemPackages = gnomeExtensions;

  hm.dconf.settings =
  {

    "org/gnome/shell" =
    {
      disabled-extensions = [];
      disable-user-extensions = false; # Hopefully enables all extensions after reboot

      enabled-extensions = map (extension: extension.extensionUuid) gnomeExtensions; # Enable all gnomeExtensions
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
      move-item-first = true; # Move to top of the list when selected
      paste-button = false;

      enable-keybindings = false;
      history-size = 150;
    };

    "org/gnome/shell/extensions/just-perfection" =
    {
      panel = false;
      panel-in-overview = true;

      # Disable request for payment on boot
      support-notifier-type = 0;

      calendar = false;

      window-demands-attention-focus = true; # Just make window appear when it's done with a task


      switcher-popup-delay = true; # No delay with alt-tab
      startup-status = 1; # Start on overview when rebooting
    };

    "org/gnome/shell/extensions/tiling-assistant" =
    {
      restore-window = []; # Let us use Super+Down

      tile-left-half = ["<Super>a" "<Super>Left"];
      tile-right-half = ["<Super>d" "<Super>Right"];
      tile-top-half = ["<Super>w"];
      tile-bottom-half = ["<Super>s"];

      enable-advanced-experimental-features = true;
      default-move-mode = 2; # Indirectly disables edge tiling via the GUI, so we only do it via keybinds
    };

    "org/gnome/shell/extensions/sane-airplane-mode" =
    {
      enable-airplane-mode = false;
      enable-bluetooth = false; # Misleading: actually means when turning off airplane mode, bluetooth doesn't go on
    };
  };
}
