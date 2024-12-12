{ inputs, lib, ... }:

{
  # Preview via eza automatically
  hm.programs.yazi.settings.plugin.prepend_previewers =
  [
    {
      name = "*/";
      run = "eza-preview";
    }
  ];

  # Use E to toggle previewing recursively
  hm.programs.yazi.keymap.manager.prepend_keymap =
  [
    {
      on = lib.singleton "E";
      run = "plugin eza-preview";
      desc = "Toggle tree/list dir preview";
    }
  ];

  hm.programs.yazi.plugins =
  {
    eza-preview = inputs.eza-preview-yazi;
  };
}