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
  let normal =
  {
    up = "no_op";
    down = "no_op";
    left = "no_op";
    right = "no_op";

    # w and shift+w for moving around with special characters EXCLUDED
    w = "move_next_word_start";
    W = "move_prev_word_start";

    # e and shift+e for moving around with special characters INCLUDED
    e = "move_next_long_word_start";
    E = "move_prev_long_word_start";

    # These are weird and I likely won't use them, but I shouldn't get rid of a bind
    b = "move_next_word_end";
    B = "move_next_long_word_end";
  };
  in
  {
    inherit normal;
    insert = # And we WILL only use normal mode for moving around
    {
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";
    };
    select = normal; # Reuse custom normal
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
