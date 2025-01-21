{
  hm.programs.kitty.settings =
  {
    active_tab_title_template = "{title}{keyboard_mode}";
  };

  # Modal bindings for managing tabs
  hm.programs.kitty.extraConfig =
  /* bash */
  ''
    # Flags have to be before the actual binding to work
    # Doing something unknown leaves the mode
    map --new-mode KITTAB --on-unknown end ctrl+k

    # Exit mode automatically when creating/deleting tabs
    map --mode KITTAB t combine : new_tab : pop_keyboard_mode
    map --mode KITTAB d combine : close_window : pop_keyboard_mode

    map --mode KITTAB h previous_tab
    map --mode KITTAB l next_tab
    map --mode KITTAB shift+h move_tab_backward
    map --mode KITTAB shift+l move_tab_forward

    map --mode KITTAB k scroll_line_up
    map --mode KITTAB j scroll_line_down
    map --mode KITTAB shift+k scroll_to_prompt -1
    map --mode KITTAB shift+j scroll_to_prompt 1

    # Exit mode
    map --mode KITTAB i pop_keyboard_mode
    map --mode KITTAB esc pop_keyboard_mode

  '';
}