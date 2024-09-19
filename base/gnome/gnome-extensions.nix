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
  ];

in
{
  hm =
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
        history-size = 50;
      };

      "org/gnome/shell/extensions/just-perfection" =
      {
        panel = false;
        panel-in-overview = true;
        calendar = false;

        window-demands-attention-focus = true; # Just make window appear when it's done with a task


        switcher-popup-delay = true; # No delay with alt-tab
        startup-status = 0; # Start on desktop when rebooting
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
    };
  };
}