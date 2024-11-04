{ pkgs, inputs, ... }:

{
  hm.programs.helix =
  {
    enable = true;
    package = inputs.helix-unstable.packages.${pkgs.system}.default; # Compile helix from source from commit adding macro support
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

    bufferline = "multiple";
    insert-final-newline = false;

  };

}
