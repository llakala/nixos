{ pkgs-unstable, pkgs, ... }:

{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs-unstable) git;

    inherit (pkgs)
      difftastic
      meld
      tig
      diff-so-fancy;
  };
}
