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
    map --new-mode KITMODE --on-unknown end ctrl+k

    # Exit mode automatically when creating/deleting tabs
    map --mode KITMODE t new_tab
    map --mode KITMODE d close_window

    map --mode KITMODE h previous_tab
    map --mode KITMODE l next_tab
    map --mode KITMODE shift+h move_tab_backward
    map --mode KITMODEshift+l move_tab_forward

    map --mode KITMODE k scroll_line_up
    map --mode KITMODE j scroll_line_down
    map --mode KITMODE shift+k scroll_to_prompt -1
    map --mode KITMODE shift+j scroll_to_prompt 1

    # Exit mode
    map --mode KITMODE i pop_keyboard_mode
    map --mode KITMODE esc pop_keyboard_mode

  '';
}
