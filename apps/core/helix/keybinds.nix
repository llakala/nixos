let
  trimSelections = keybind: [ keybind "trim_selections" ];

  # Binds that should be `move` in normal mode and `extend` in select mode
  navigationBinds = type:
  {
    # Beginning of next word. can't have selection trimmed or it never moves
    w = "${type}_next_word_start";
    A-w = "${type}_next_long_word_start";

    # End of current word
    e = trimSelections "${type}_next_word_end";
    A-e = trimSelections "${type}_next_long_word_end";

    # Beginning of current word
    E = trimSelections "${type}_prev_word_start";
    A-E = trimSelections "${type}_prev_long_word_start";

    # Same as above, but for vim muscles
    b = trimSelections "${type}_prev_word_start";
    A-b = trimSelections "${type}_prev_long_word_start";

    # As recommended in https://docs.helix-editor.com/editor.html#editorsmart-tab-section
    tab = "${type}_parent_node_end";
    S-tab = "${type}_parent_node_start";
  };


  sharedBinds = # Binds that should work exactly the same in both normal and select mode
  {
    space.n = ":config-reload"; # For when we rebuild and want to apply changes

    X = "select_line_above"; # Select line upwards from the cursor location
    x = "select_line_below"; # Select line downwards from the cursor location

    "#" = "toggle_comments";
    space.c = "no_op";

    # Use system clipboard everywhere
    y = "yank_to_clipboard";
    p = "replace_selections_with_clipboard";
    P = "paste_clipboard_after";

    # Don't yank when deleting and changing
    d = "delete_selection_noyank";
    c = "change_selection_noyank";

    # Beginning/end of line, selecting to match Helix paradigms
    H = [ "collapse_selection" "select_mode" "goto_first_nonwhitespace" "normal_mode" ];
    L = [ "collapse_selection" "select_mode" "goto_line_end" "normal_mode" ];

    g.G = "goto_file_end"; # `g.g` is file beginning, it needs the reverse

    up = "no_op";
    down = "no_op";
    left = "no_op";
    right = "no_op";

    B = "no_op";
    A-B = "no_op";
    W = "no_op";
    A-W = "no_op";

    # We have `Hi` and `Ha` for this. Goto binds without selection feels evil anyways.
    I = "no_op";
    A = "no_op";
  };
in
{
  hm.programs.helix.settings.keys =
  {
    normal = sharedBinds // navigationBinds "move" //
    {
      # Doing something like `ea` or `bi` shouldn't keep the text selected while inserting
      a = [ "append_mode" "collapse_selection" ];
      i = [ "insert_mode" "collapse_selection" ];

      esc = "keep_primary_selection"; # Escape also removes cursors, like `,`
    };

    select = sharedBinds // navigationBinds "extend" //
    {
      # Empty right now, any select-specific binds would go here
    };

    insert = # And we WILL only use normal mode for moving around
    {
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";

      S-tab = "move_parent_node_start";
    };
  };
}
