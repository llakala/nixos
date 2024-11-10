{ inputs, pkgs, ... }:

{
  hm.programs.helix =
  {
    enable = true;
    package = inputs.helix-unstable.packages.${pkgs.system}.default; # Compile helix from source, using the latest commit for binary caching

    defaultEditor = true; # Sets EDITOR environment variable
    settings.theme = "onedarker";
  };

  hm.programs.helix.settings.editor =
  {
    cursor-shape =
    {
      insert = "bar";
      normal = "block";
      select = "underline";
    };

    whitespace =
    {
      render.newline = "all";# Would implement toggling here but it fails on latest commit, see https://github.com/helix-editor/helix/issues/11856
      characters.newline = "↵";
    };

    indent-guides.render = true; # Show where indentations are with |
    mouse = false; # you'll thank me later
    bufferline = "multiple";
    insert-final-newline = false;

    # Use inline diagnostics with settings recommended from https://docs.helix-editor.com/master/editor.html#editorinline-diagnostics-section
    end-of-line-diagnostics = "hint";
    inline-diagnostics.cursor-line = "warning";
  };

}
