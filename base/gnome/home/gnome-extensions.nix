{ pkgs, ... }:


let
  gnomeExtensions = with pkgs.gnomeExtensions;
  [
    dash-to-dock
    clipboard-indicator
    just-perfection
    alphabetical-app-grid
    tiling-assistant
    status-area-horizontal-spacing
  ];
in
{
  home.packages = gnomeExtensions;

  dconf.settings =
  {

    "org/gnome/shell" =
    {
      disable-user-extensions = false;

      enabled-extensions =  map (extension: extension.extensionUuid) gnomeExtensions;
    };


    "org/gnome/shell/extensions/dash-to-dock" =
    {
      apply-custom-theme = true;

      autohide-in-fullscreen = true;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      hide-delay = 0.15;
      show-delay = 0.15;
      animation-time = 0.05;

      require-pressure-to-show = false;

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
      history-size = 50;
    };

    "org/gnome/shell/extensions/just-perfection" =
    {
      panel = false;
      panel-in-overview = true;
      calendar = false;

      window-demands-attention-focus = true;


      switcher-popup-delay = true;
      startup-status = 0;
    };
  };
}