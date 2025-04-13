{ inputs, ... }:

let
  plugins = inputs.yazi-plugins;

in
{
  programs.yazi.plugins =
  {
    jump-to-char = plugins + "/jump-to-char.yazi";
    chmod = plugins + "/chmod.yazi";
    git = plugins + "/git.yazi";
  };

  programs.yazi.settings.keymap.manager.prepend_keymap =
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

  # Check the init.lua in the `yazi` for where I set theme stuff
  programs.yazi.settings.yazi.plugin.prepend_fetchers =
  [
    {
      id = "git";
      name = "*";
      run = "git";
    }

    {
      id = "git";
      name = "*/";
      run = "git";
    }
  ];

}
