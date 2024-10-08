{ lib, pkgs, pkgs-unstable, ... }:


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
    normal =
    {
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";

      # Moving around with special characters EXCLUDED
      w = "move_next_word_start";
      W = "move_prev_word_start";

      # Moving around with special characters INCLUDED
      e = "move_next_long_word_start";
      E = "move_prev_long_word_start";

      # w and W, but including spaces
      b = "move_next_word_end";
      B = "move_prev_word_end";

      # e and E, but including spaces
      n = "move_next_long_word_end";
      N = "move_prev_long_word_end";

      C-r = ":config-reload"; # Ctrl+r. Would ideally be :cr, but no way to make custom command aliases :(

      y = "yank_to_clipboard";
      p = "paste_clipboard_after";
      P = "paste_clipboard_before";
      R = "replace_selections_with_clipboard";

      d = "delete_selection_noyank";
      c = "change_selection_noyank";
    };

    insert = # And we WILL only use normal mode for moving around
    {
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";
    };

    select = # Same binds as normal, but move --> extend so selection works as expected
    {
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";

      w = "extend_next_word_start";
      W = "extend_prev_word_start";

      e = "extend_next_long_word_start";
      E = "extend_prev_long_word_start";

      b = "extend_next_word_end";
      B = "extend_prev_word_end";

      n = "extend_next_long_word_end";
      N = "extend_prev_long_word_end";

      y = "yank_to_clipboard";
      p = "paste_clipboard_after";
      P = "paste_clipboard_before";
      R = "replace_selections_with_clipboard";

      d = "delete_selection_noyank";
      c = "change_selection_noyank";   
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
