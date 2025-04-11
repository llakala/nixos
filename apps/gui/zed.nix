{
  custom.programs.zed-editor.enable = false;

  custom.programs.zed-editor.settings =
  {
    # AI stupid stuff
    assistant.enabled = false;
    features.inline_completion_provider = "none";

    auto_install_extensions.nix = true;

    base_keymap = "VSCode";

    gutter.line_numbers = false;
    git.inline_blame.enabled = false;
  };

}
