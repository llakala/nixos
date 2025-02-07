{ pkgs-unstable, ... }:

{
  hm.programs.helix =
  {
    enable = true;
    package = pkgs-unstable.helix;

    defaultEditor = false; # Sets EDITOR environment variable
    settings.theme = "snazzy";
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

    lsp =
    {
      display-inlay-hints = true; # Stuff like type hints (if supported by the language server)
      display-messages = true;

      display-signature-help-docs = false; # Disable documentation popup under parameter hints
    };

    indent-guides.render = true; # Show where indentations are with |
    mouse = false; # you'll thank me later
    bufferline = "multiple";
    insert-final-newline = false;
    smart-tab.enable = true;

    completion-timeout = 150;
    completion-trigger-len = 1;
    completion-replace = true;

    color-modes = true;

    # Use inline diagnostics with settings recommended from https://docs.helix-editor.com/master/editor.html#editorinline-diagnostics-section
    end-of-line-diagnostics = "hint";
    inline-diagnostics.cursor-line = "warning";

    continue-comments = false; # I'd like to have this on a bind, but that currently doesn't exist
  };

}
