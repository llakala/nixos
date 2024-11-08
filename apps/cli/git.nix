{ config, pkgs-unstable, lib, pkgs, ... }:

{
  hm.programs.git =
  {
    enable = true;
    package = pkgs-unstable.gitFull;
    userName = config.baseVars.fullName; # Full name associated with commits
    userEmail = "78693624+quatquatt@users.noreply.github.com"; # github noreply email
    difftastic.enable = true;

    
    extraConfig = # See https://git-scm.com/docs/git-config
    {
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      diff.algorithm = "histogram";

      pull.ff = "only";
      push.useForceIfIncludes = true;

      rebase.autoStash = true; # Lets us use `git rebase -I` with uncommented changes
      rebase.autoSquash = true; # Treat commits with prepend messages (squash! fixup!) as they should be


      merge.conflictstyle = "diff3";
      merge.directoryRenames = true; # Renamed directories don't cause a merge conflict

      merge.tool = "meld";
      mergetool.meld.path = lib.getExe pkgs.meld;
    };

    aliases =
    {
      amend = "commit --amend --no-edit";
      reword = "commit --amend";
      force = "push --force-with-lease --force-if-includes";

      undo = "reset HEAD~1 --mixed"; # Undo last commit

      brb = "stash push --staged"; # Leave a branch temporarily. Staged files are stashed, while unstaged will travel with us to the other branch
      imback = "stash pop";

      hire = "stage --patch"; # Stage specific changes, one by one
      fire = "restore --staged --patch"; # Unstage specific staged changes
      kill = "restore --patch"; # Undo an unstaged change

      staged = "diff --staged";
      unstaged = "diff";

      history = "log --patch";

      # Used like this to combine last three commits: `git combine 3 "awesome commit message here"`
      combine = ''!f() { git reset HEAD && git branch -D backup-before-combine && git branch backup-before-combine && git reset --soft HEAD~"$1" && git commit -m "$2"; }; f'';
      uncombine = "reset --soft backup-before-combine"; # Doesn't touch staged and unstaged files, just changes the commit history
    };
  };
}
