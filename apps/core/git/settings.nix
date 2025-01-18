{ lib, pkgs, ... }:

{
  # See https://git-scm.com/docs/git-config. Need to do `iniContent` to force default value
  hm.programs.git.iniContent =
  {
    push.autoSetupRemote = true;
    init.defaultBranch = "main";
    rerere.enabled = true;

    commit.verbose = true; # Show changes when writing commit message so we remember what we changed

    diff.algorithm = "histogram";
    diff.renames = "copies"; # Be as smart for renames as possible
    diff.colorMoved = true;

    apply.whitespace = "error";
    diff.wsErrorHighlight = "all"; # Highlight all whitespace errors, not just new ones

    pull.ff = "only"; # Prevent merging if changes are trivial, but if they're not, require an explicit merge
    push.useForceIfIncludes = true;

    branch.sort = "-committerdate";
    log.abbrevCommit = true; # Show short version of commit hashes by default

    rebase.autoSquash = true; # Treat commits with prepend messages (squash! fixup!) as they should be

    merge.conflictstyle = "diff3";
    merge.directoryRenames = true; # Renamed directories don't cause a merge conflict

    merge.tool = "meld";
    mergetool.meld =
    {
      path = lib.getExe pkgs.meld;
      useAutoMerge = true;
    };
  };
}