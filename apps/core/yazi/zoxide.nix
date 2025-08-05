{ pkgs, ... }:

{
  hm.programs.yazi.package = pkgs.yazi.override
  {
    # Dependencies from the package definition, but without zoxide
    # Lets Yazi reuse our zoxide definition so it tracks our yazi directories too
    # If you're in the future, check the file to see if dependencies have changed:
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/ya/yazi/package.nix
    optionalDeps = with pkgs;
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
