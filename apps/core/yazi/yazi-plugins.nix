{ inputs, lib, ... }:

let
  plugins = inputs.yazi-plugins;

in
{
  hm = # Use unstable home-manager module for compatibility with Yazi package update
  {
    disabledModules = lib.singleton "${inputs.home-manager}/modules/programs/yazi.nix";
    imports = lib.singleton "${inputs.home-manager-yazi}/modules/programs/yazi.nix";
  };

  hm.programs.yazi.plugins =
  {
    jump-to-char = plugins + "/jump-to-char.yazi";
    chmod = plugins + "/chmod.yazi";
    git = plugins + "/git.yazi";
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


  hm.programs.yazi.initLua =
  /* lua */
  ''
    THEME.git = THEME.git or {}

    THEME.git.modified_sign = "M"
    THEME.git.added_sign = "A"
    THEME.git.deleted_sign = "D"
    THEME.git.untracked_sign = "A"

    require("git"):setup()
  '';

  hm.programs.yazi.settings.plugin.prepend_fetchers =
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
