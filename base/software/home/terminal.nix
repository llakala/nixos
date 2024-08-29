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
  };

  programs.kitty.keybindings =
  {
    "ctrl+q" = "close_window";
  };
}