{ lib, pkgs, pkgs-unstable, ... }:

let navigationBinds = type: 
{
  up = "no_op";
  down = "no_op";
  left = "no_op";
  right = "no_op";


  # Go till the next word *starts*. w+a inserts after "word "
  w = "${type}_next_word_start";
  W = "${type}_prev_word_start";

  # w/W, but for WORDS, special characters included.
  A-w = "${type}_next_long_word_start"; # alt-w
  A-W = "${type}_prev_long_word_start"; # alt-shift-w


  # Go till the next word *ends*. e+a inserts after "word"
  e = "${type}_next_word_end";
  E = "${type}_prev_word_end";

  # e/E, but for WORDS, special characters included. 
  A-e = "${type}_next_long_word_end"; # alt-e
  A-E = "${type}_prev_long_word_end"; # alt-shift-e


  C-r = ":config-reload"; # Ctrl+r. Would ideally be :cr, but no way to make custom command aliases :(

  y = "yank_to_clipboard";
  p = "paste_clipboard_after";
  P = "paste_clipboard_before";
  R = "replace_selections_with_clipboard"; # Easier d+p

  d = "delete_selection_noyank";
  c = "change_selection_noyank"; # Easier d+i
};
in
{
  hm.programs.helix =
  {
    enable = true;
    package = pkgs-unstable.helix;
    defaultEditor = true; # Sets EDITOR environment variable
    settings.theme = "onedarker";
  };

  hm.programs.helix.settings.editor =
  {
    indent-guides.render = true; # Show where indentations are with |

    mouse = false; # you'll thank me later

    cursor-shape =
    {
      insert = "bar";
      normal = "block";
      select = "underline";
    };
  };

  hm.programs.helix.settings.keys =
  {
    # Normal and select use the same custom binds, but normal moves the selection, while select extends the selection
    normal = navigationBinds "move";
    select = navigationBinds "extend";

    insert = # And we WILL only use normal mode for moving around
    {
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";
    };

  };


  hm.programs.helix.languages.language =
  [
    {
      name = "nix";
      auto-format = false;
      language-servers = lib.singleton "nil";
    }
    {
      name = "python";
      auto-format = false;
      language-servers = lib.singleton "pylsp";
    }
  ];

  hm.programs.helix.languages.language-server = # Define language server executables here so helix can access them
  {
    nil.command = lib.getExe pkgs.nil;
    pylsp.command = lib.getExe pkgs.python3Packages.python-lsp-server;
  };
}
