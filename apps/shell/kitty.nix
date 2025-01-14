{ pkgs-unstable, ... }:

{
  hm.programs.kitty =
  {
    enable = true;
    package = pkgs-unstable.kitty;

    # We don't specify the font in Kitty since it broke as of 24.11
    # Instead, we allow it to use the system monospace font

    themeFile = "Kaolin_Aurora"; # Reference exact names here https://github.com/kovidgoyal/kitty-themes/blob/389a222143ffb0ff38abea187fbc21b1221b94c0/themes.json#L2
  };

  hm.programs.kitty.settings =
  {
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

  # Modal bindings for managing tabs
  hm.programs.kitty.extraConfig =
  /* bash */
  ''
    # Flags have to be before the actual binding to work
    # Doing something unknown leaves the mode
    map --new-mode mt --on-unknown end ctrl+k

    # Exit mode automatically when creating/deleting tabs
    map --mode mt t combine : new_tab : pop_keyboard_mode
    map --mode mt d combine : close_window : pop_keyboard_mode

    map --mode mt h previous_tab
    map --mode mt l next_tab
    map --mode mt shift+h move_tab_backward
    map --mode mt shift+l move_tab_forward

    map --mode mt k scroll_line_up
    map --mode mt j scroll_line_down
    map --mode mt shift+k scroll_to_prompt -1
    map --mode mt shift+j scroll_to_prompt 1

    # Exit mode
    map --mode mt i pop_keyboard_mode
    map --mode mt esc pop_keyboard_mode

  '';

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
}
