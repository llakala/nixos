_:
{
  inputs = {
    less.path = "/less";
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
