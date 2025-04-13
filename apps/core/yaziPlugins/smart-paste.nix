{ lib, ... }:

{
  programs.yazi.settings.keymap.manager.prepend_keymap = lib.singleton
  {
    desc = "Paste into a directory if we're hovering over it";
    on = lib.singleton "p";
    run = "plugin smart-paste";
  };

  programs.yazi.plugins.smart-paste = ./smart-paste;
}
