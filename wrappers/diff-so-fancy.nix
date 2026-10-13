{ promise, ... }:
{
  inputs = {
    less.from = { parent }: parent.less;
  };

  mutations = {
    "/git".settings = promise (
      { inputs, results }:
      let
        inherit (inputs.nixpkgs) lib;
      in {
        # Can't use ${finalWrapper} because of infrec - this module modifies
        # the git settings here, but needs to read from it too. Could solve
        # it with some `lib.fix`, but this is fine for now
        interactive.diffFilter = "diff-so-fancy --patch";
        pager.diff = "diff-so-fancy | ${lib.getExe results.less} -+F"; # Disable quit-if-one-screen for diffs
        diff-so-fancy.markEmptyLines = false; # So nothing else looks like `red reverse`
      }
    );
  };
}
