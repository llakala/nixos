let navigationBinds = type:
{
  up = "no_op";
  down = "no_op";
  left = "no_op";
  right = "no_op";

  X = "extend_line_above"; # Select line upwards

  # Select next word, plus extra space afterwards. Good for adding on via `w+a`
  w = "${type}_next_word_start";
  W = "${type}_prev_word_start";
  A-w = "${type}_next_long_word_start"; # alt-w
  A-W = "${type}_prev_long_word_start"; # alt-shift-w

  # Select next word, plus a space prior. Good for deletion via `e+d`
  e = "${type}_next_word_end";
  E = "${type}_prev_word_end";
  A-e = "${type}_next_long_word_end"; # alt-e
  A-E = "${type}_prev_long_word_end"; # alt-shift-e

  # Select next word, with no spaces selected at all. Great for replacing via `q+c`
  q = "@emiw"; # Uses macros, added in unstable helix version
  A-q = "@emiW";



  C-r = ":config-reload"; # Ctrl+r. Would ideally be :cr, but no way to make custom command aliases :(

  y = "yank_to_clipboard";
  p = "paste_clipboard_after";
  P = "paste_clipboard_before";
  R = "replace_selections_with_clipboard"; # Easier d+p

  d = "delete_selection_noyank";
  c = "change_selection_noyank"; # Easier d+i

  H = "goto_first_nonwhitespace";
  L = "goto_line_end";

  space.x = ":toggle whitespace.render all none"; # ` x` shows whitespace
};
in
{
  hm.programs.helix.settings.keys =
  {
    # Normal and select use the same custom binds, but normal moves the selection, while select extends the selection
    normal = navigationBinds "move" //
    {
      esc = "keep_primary_selection"; # Escape also removes cursors, like `,`
    };

    select = navigationBinds "extend";

    insert = # And we WILL only use normal mode for moving around
    {
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";
    };
  };
}
