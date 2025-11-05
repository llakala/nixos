{ lib, pkgs, self, ... }:

{
  # See https://git-scm.com/docs/git-config. Need to do `iniContent` to force default value
  hm.programs.git.iniContent = {
    push.autoSetupRemote = true;
    init.defaultBranch = "main";

    rerere.enabled = true;
    rebase.autoSquash = true; # Treat commits with prepend messages (squash! fixup!) as they should be

    commit.verbose = true; # Show changes when writing commit message so we remember what we changed

    core.pager = lib.getExe self.wrappers.less.drv;

    diff.algorithm = "histogram";
    diff.renames = "copies"; # Be as smart for renames as possible
    diff.colorMoved = true;

    apply.whitespace = "error";
    diff.wsErrorHighlight = "all"; # Highlight all whitespace errors, not just new ones

    status.showUntrackedFiles = "all";

    pull.ff = "only"; # Prevent merging if changes are trivial, but if they're not, require an explicit merge
    push.useForceIfIncludes = true;
    push.default = "current"; # Only push current branch, and don't force-push everything when force pushing

    branch.sort = "-committerdate";
    log.abbrevCommit = true; # Show short version of commit hashes by default
    log.follow = true; # Show short version of commit hashes by default

    merge.conflictstyle = "diff3";
    merge.directoryRenames = true; # Renamed directories don't cause a merge conflict

    merge.tool = "meld";
    mergetool.meld = {
      path = lib.getExe pkgs.meld;
      useAutoMerge = true;
    };
  };
}
