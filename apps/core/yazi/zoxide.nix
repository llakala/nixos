{ pkgs-unstable, ... }:

{
  programs.yazi.package = pkgs-unstable.yazi.override
  {
    # Dependencies from the package definition, but without zoxide
    # Lets Yazi reuse our zoxide definition so it tracks our yazi directories too
    # If you're in the future, check the file to see if dependencies have changed:
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/ya/yazi/package.nix
    optionalDeps = with pkgs-unstable;
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

  # See the init.lua for other zoxide snippets
}
