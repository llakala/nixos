{ lib, pkgs, ... }:

{
  # See https://git-scm.com/docs/git-config. Need to do `iniContent` to force default value
  hm.programs.git.iniContent =
  {
    push.autoSetupRemote = true;
    init.defaultBranch = "main";
    rerere.enabled = true;

    # Show changes when writing commit message so we remember what we changed
    commit.verbose = true;

    diff.algorithm = "histogram";

    # Be as smart for renames as possible
    diff.renames = "copies";
    diff.colorMoved = true;

    apply.whitespace = "error";

    # Highlight all whitespace errors, not just new ones
    diff.wsErrorHighlight = "all";

    # Prevent merging if changes are trivial, but if they're not, require an explicit merge
    pull.ff = "only";
    push.useForceIfIncludes = true;

    # Only push current branch, and don't force-push everything when force pushing
    push.default = "current";

    branch.sort = "-committerdate";

    # Show short version of commit hashes by default
    log.abbrevCommit = true;

    # Treat commits with prepend messages (squash! fixup!) as they should be
    rebase.autoSquash = true;

    merge.conflictstyle = "diff3";

    # Renamed directories don't cause a merge conflict
    merge.directoryRenames = true;

    merge.tool = "meld";
    mergetool.meld =
    {
      path = lib.getExe pkgs.meld;
      useAutoMerge = true;
    };
  };
}
