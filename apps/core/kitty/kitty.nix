{
  features.terminal = "kitty"; # Change if I ever stop using Kitty

  hm.programs.kitty =
  {
    enable = true;

    # We don't specify the font in Kitty since it broke as of 24.11
    # Instead, we allow it to use the system monospace font

    themeFile = "Kaolin_Aurora"; # Reference exact names here https://github.com/kovidgoyal/kitty-themes/blob/389a222143ffb0ff38abea187fbc21b1221b94c0/themes.json#L2
  };

  hm.programs.kitty.settings =
  {
    allow_remote_control = true;
    listen_on = "unix:@kitty";
    enabled_layouts = "splits:split_axis=horizontal";

    scrollback_lines = 5000;

    underline_hyperlinks = "always";

    linux_display_server = "x11"; # Make titlebar normal gnome titlebar rather than ugly kitty one
    font_size = 12;

    background_opacity = "0.98";

    copy_on_select = true;
    notify_on_cmd_finish = "unfocused 60.0 notify";

    confirm_os_window_close = 0; # Close instead of asking "Would you like to close?"
    tab_bar_edge = "top";
    tab_bar_style = "powerline";
  };

  hm.programs.kitty.keybindings =
  {
    "ctrl+q" = "close_os_window"; # Quit application
    "ctrl+w" = "close_window"; #  Prioritizes internal windows > tabs
    "ctrl+t" = "new_tab";

    # Default binds should do nothing
    "ctrl+shift+t" = "no_op";
    "ctrl+shift+enter" = "no_op";
    "ctrl+shift+[" = "no_op";
    "ctrl+shift+]" = "no_op";
  };
}
