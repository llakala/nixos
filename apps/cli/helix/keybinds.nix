let
  moveAndDeselect = action:
    if builtins.isString action then
      [ action "collapse_selection" ]
    else if builtins.isList action then
      action ++ [ "collapse_selection" ]
    else throw "Action ${action} was of type ${builtins.typeOf action}. It was expected to be a list or a string.";


  sharedBinds = # Binds that should work in both normal and select mode
  {
    # Select next word, with no spaces selected at all. Great for replacing via `q+c`
    q = "@emiw"; # Uses macros, added in unstable helix version
    A-q = "@emiW";


    space.x = ":toggle whitespace.render all none"; # ` x` shows whitespace

    C-r = ":config-reload"; # Ctrl+r. Would ideally be :cr, but no way to make custom command aliases :(


    X = "extend_line_above"; # Select line upwards

    # Use system clipboard everywhere
    y = "yank_to_clipboard";
    p = "paste_clipboard_after";
    P = "paste_clipboard_before";
    R = "replace_selections_with_clipboard"; # Easier d+p

    # Don't yank when deleting and changing
    d = "delete_selection_noyank";
    c = "change_selection_noyank";

    H = "goto_first_nonwhitespace";
    L = "goto_line_end";

    # More ergonomic alternative to `><`
    tab = "indent";
    S-tab = "unindent";

    up = "no_op";
    down = "no_op";
    left = "no_op";
    right = "no_op";

    b = "no_op";
    B = "no_op";
    A-b = "no_op";
    A-B = "no_op";


  };
in
{
  hm.programs.helix.settings.keys =
  {
    normal = sharedBinds //
    {
      # Beginning of next word
      w = moveAndDeselect [ "move_next_word_start" "move_char_right" ];
      A-w = moveAndDeselect [ "move_next_long_word_start" "move_char_right" ];

      # Beginning of current word
      W = moveAndDeselect "move_prev_word_start";
      A-W = moveAndDeselect "move_prev_long_word_start";

      # End of current word
      e = moveAndDeselect "move_next_word_end";
      A-e = moveAndDeselect "move_next_long_word_end";

      # End of previous word
      E = moveAndDeselect "move_prev_word_end";
      A-E = moveAndDeselect "move_prev_long_word_end";


      esc = "keep_primary_selection"; # Escape also removes cursors, like `,`
    };

    select = sharedBinds //
    {
      # Beginning of next word
      w = "extend_next_word_start";
      A-w = "extend_next_long_word_start";

      # Beginning of current word
      W = "extend_prev_word_start";
      A-W = "extend_prev_long_word_start";

      # End of current word
      e = "extend_next_word_end";
      A-e = "extend_next_long_word_end";

      # End of previous word
      E = "extend_prev_word_end";
      A-E = "extend_prev_long_word_end";
    };

    insert = # And we WILL only use normal mode for moving around
    {
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";
    };
  };
}
