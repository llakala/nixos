{ config, pkgs-unstable, ... }:

{
  hm.programs.yazi =
  {
    enable = true;
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

  hm.programs.yazi.package = pkgs-unstable.yazi.override
  {
    # Dependencies from the package definition, but without zoxide
    # Lets Yazi reuse our zoxide definition so it tracks our yazi directories too
    optionalDeps =  with pkgs-unstable;
    [
      jq
      poppler_utils
      _7zz
      ffmpeg
      fd
      ripgrep
      fzf
      imagemagick
      chafa
    ];
  };

}
