{ lib, pkgs, ... }:
{
  hm.programs.git.iniContent = # See https://git-scm.com/docs/git-config. Need to do `iniContent` to force default value
  {
    push.autoSetupRemote = true;
    init.defaultBranch = "main";
    apply.whitespace = "error";

    commit.verbose = true; # Show changes when writing commit message so we remember what we changed

    diff.algorithm = "histogram";
    diff.wsErrorHighlight = "all"; # Highlight all whitespace errors, not just new ones

    pull.ff = "only"; # Prevent merging if changes are trivial, but if they're not, require an explicit merge
    push.useForceIfIncludes = true;

    rebase.autoSquash = true; # Treat commits with prepend messages (squash! fixup!) as they should be

    merge.conflictstyle = "diff3";
    merge.directoryRenames = true; # Renamed directories don't cause a merge conflict

    merge.tool = "meld";
    mergetool.meld.path = lib.getExe pkgs.meld;
  };
}