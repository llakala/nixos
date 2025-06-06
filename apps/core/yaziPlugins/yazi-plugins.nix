{ pkgs-unstable, ... }:

{
  hm.programs.yazi.plugins =
  {
    inherit (pkgs-unstable.yaziPlugins)
      jump-to-char
      chmod
      git
      smart-paste;
  };

  hm.programs.yazi.keymap.mgr.prepend_keymap =
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

    {
      on = "p";
      desc = "Paste into a directory if we're hovering over it";
      run = "plugin smart-paste";
    }
  ];


  hm.programs.yazi.initLua =
  /* lua */
  ''
    th.git = th.git or {}

    th.git.modified_sign = "M"
    th.git.added_sign = "A"
    th.git.deleted_sign = "D"
    th.git.untracked_sign = "A"

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
