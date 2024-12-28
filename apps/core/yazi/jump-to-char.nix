{ inputs, lib, ... }:

let
  plugins = inputs.yazi-plugins;
  jump-to-char = "${plugins}/jump-to-char.yazi";
in
{
  hm.programs.yazi.plugins =
  {
    inherit jump-to-char;
  };

  hm.programs.yazi.keymap.manager.prepend_keymap = lib.singleton
  {
    on = "f";
    run = "plugin jump-to-char";
    desc = "Jump to char";
  };

}