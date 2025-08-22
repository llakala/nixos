{
  custom.programs.zed-editor.enable = false;

  custom.programs.zed-editor.settings = {
    assistant.enabled = false; # AI stupid stuff
    features.inline_completion_provider = "none";

    auto_install_extensions.nix = true;

    base_keymap = "VSCode";

    gutter.line_numbers = false;
    git.inline_blame.enabled = false;
  };

}
