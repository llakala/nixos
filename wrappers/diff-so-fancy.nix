_:
{
  inputs = {
    less.path = "/less";
  };

  options = {
    # Waiting on https://github.com/NixOS/nixpkgs/pull/508799 to make it to
    # nixos-unstable
    package.defaultFunc =
      { inputs }:
      let
        inherit (inputs.nixpkgs.pkgs) diff-so-fancy fetchFromGitHub;
      in
      diff-so-fancy.overrideAttrs {
        src = fetchFromGitHub {
          owner = "so-fancy";
          repo = "diff-so-fancy";
          rev = "6af77b229c8a6307c11ca2fd46492fc38866dc37";
          hash = "sha256-cKw10KdfGr1O9br5j5OLxabFte1XwV/7F3DBkrbN5RQ=";
        };
      };
  };

  mutations = {
    "/git".settings =
      { inputs }:
      let
        inherit (inputs.nixpkgs) lib;
        lessWrapper = inputs.less {};
      in {
        # Can't use ${finalWrapper} because of infrec - this module modifies
        # the git settings here, but needs to read from it too. Could solve
        # it with some `lib.fix`, but this is fine for now
        interactive.diffFilter = "diff-so-fancy --patch";
        pager.diff = "diff-so-fancy | ${lib.getExe lessWrapper} -+F"; # Disable quit-if-one-screen for diffs
        diff-so-fancy.markEmptyLines = false; # So nothing else looks like `red reverse`
      };
  };
}
