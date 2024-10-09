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
  hm =
  {
    programs.kitty =
    {
      enable = true;
      # shellIntegration.enableZshIntegration = true; # Not needed since ZSH checks for the shell variable

      font = myFont;

      theme = "Kaolin Aurora";
    };

    programs.kitty.settings =
    {
      scrollback_lines = 5000;

      linux_display_server = "x11"; # Make titlebar normal gnome titlebar rather than ugly kitty one

      bold_is_bright = true;
      background_opacity = "0.98";

      copy_on_select = true;

      confirm_os_window_close = 0; # Close instead of asking "Would you like to close?"

      tab_bar_edge = "top";
      tab_bar_style = "powerline";
    };

    programs.kitty.keybindings =
    {
      "ctrl+q" = "close_os_window"; # Quit application
      "ctrl+w" = "close_window"; #  Prioritizes internal windows > tabs

      "ctrl+t" = "new_tab";

      "ctrl+k" = "new_window"; # Split screen
      "ctrl+j" = "previous_window";
      "ctrl+l" = "next_window";


      # Default binds should do nothing
      "ctrl+shift+t" = "no_op";
      "ctrl+shift+enter" = "no_op";
      "ctrl+shift+[" = "no_op";
      "ctrl+shift+]" = "no_op";

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
  };

  environment.variables.TERMINAL = "kitty";
}