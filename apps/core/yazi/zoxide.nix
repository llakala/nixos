{ pkgs-unstable, ... }:

{
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

  # Makes yazi update the zoxide database on navigation
  # From https://github.com/sxyazi/yazi/discussions/860
  hm.programs.yazi.initLua =
  /* lua */
  ''
    require("zoxide"):setup
    {
      update_db = true,
    }
  '';
}