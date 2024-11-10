{
  hm.programs.helix =
  {
    enable = true;
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

    whitespace =
    {
      render.newline = "all";# Would implement toggling here but it fails on latest commit, see https://github.com/helix-editor/helix/issues/11856
      characters.newline = "↵";
    };

    # Use inline diagnostics with settings recommended from https://docs.helix-editor.com/master/editor.html#editorinline-diagnostics-section
    end-of-line-diagnostics = "hint";
    inline-diagnostics.cursor-line = "warning";
  };

}
