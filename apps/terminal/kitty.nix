{
  hm.programs.kitty =
  {
    enable = true;
    # shellIntegration.enableZshIntegration = true; # Not needed since ZSH checks for the shell variable

    # We don't specify the font in Kitty since it broke as of 24.11
    # Instead, we allow it to use the system monospace font

    themeFile = "Kaolin_Aurora"; # Reference exact names here https://github.com/kovidgoyal/kitty-themes/blob/389a222143ffb0ff38abea187fbc21b1221b94c0/themes.json#L2
  };

  hm.programs.kitty.settings =
  {
    scrollback_lines = 5000;

    linux_display_server = "x11"; # Make titlebar normal gnome titlebar rather than ugly kitty one

    bold_is_bright = true;
    font_size = 12;

    background_opacity = "0.98";

    copy_on_select = true;

    confirm_os_window_close = 0; # Close instead of asking "Would you like to close?"

    tab_bar_edge = "top";
    tab_bar_style = "powerline";
  };

  hm.programs.kitty.keybindings =
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
  hm.dconf.settings."org/gnome/settings-daemon/plugins/media-keys".custom-keybindings =
  [
    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/"
  ];
  hm.dconf.settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal" =
  {
    name = "Open terminal";
    command = "kitty";
    binding = "<Super>t";
  };

  environment.variables.TERMINAL = "kitty";
  environment.variables.TERM = "kitty";
}
