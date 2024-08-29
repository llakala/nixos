{ pkgs, ... }:

let
  myFont =
  {
    name = "Monocraft";
    package = pkgs.monocraft;
    size = 12;
  };
in
{

  programs.kitty =
  {
    enable = true;
    # shellIntegration.enableZshIntegration = true; # Not needed since ZSH checks for the shell variable

    font = myFont;

    theme = "Adwaita darker";
  };

  programs.kitty.settings =
  {
    linux_display_server = "x11"; # Make titlebar normal gnome titlebar rather than ugly kitty one

    bold_is_bright = true;
    background_opacity = "0.9";

    copy_on_select = true;
  };

  programs.kitty.keybindings =
  {
    "ctrl+q" = "close_window";
  };


  # Open terminal with Super+T
  dconf.settings."org/gnome/settings-daemon/plugins/media-keys".custom-keybindings =
  [
    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/"
  ];
  dconf.settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal" =
  {
    name = "Open terminal";
    command = "kitty";
    binding = "<Super>t";
  };
}