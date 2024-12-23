{config, pkgs-unstable, ... }:

{
  hm.programs.yazi =
  {
    enable = true;
    package = pkgs-unstable.yazi;
    shellWrapperName = "y";
  };

  hm.programs.yazi.settings.opener.edit = # Custom options when opening a file
  [
    {
      run = ''${config.baseVars.editor} "$@" '';
      desc = "Open with the default editor.";
      block = true;
    }
  ];

  hm.programs.yazi.settings.manager =
  {
    sort_by = "natural";
    sort_dir_first = true;

  };

}
