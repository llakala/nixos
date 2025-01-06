{ inputs, ... }:

let
  plugins = inputs.yazi-plugins;

  jump-to-char = plugins + "/jump-to-char.yazi";
  chmod = plugins + "/chmod.yazi";
in
{
  hm.programs.yazi.plugins =
  {
    inherit jump-to-char;
    inherit chmod;
  };

  hm.programs.yazi.keymap.manager.prepend_keymap =
  [
    {
      on = "f";
      run = "plugin jump-to-char";
      desc = "Jump to char";
    }


    {
      on = [ "c" "m" ];
      run = "plugin chmod";
      desc = "Chmod on selected files";
    }

  ];
}