{
  config,
  ...
}:

{
  hm.programs.git =
  {
    enable = true;
    userName = config.baseVars.fullName; # Full name associated with commits
    userEmail = "78693624+quatquatt@users.noreply.github.com"; # github noreply email

    extraConfig =
    {
      push.autoSetupRemote = true;
      init.defaultBranch = "main";

      pull.ff = "only";
      push.useForceIfIncludes = true;

      rebase.autoStash = true; # Lets us use `git rebase -I` with uncommented changes
      rebase.autoSquash = true; # Automatically make
    };

    aliases =
    {
      oops = "commit --amend --no-edit";
      reword = "commit --amend";
      force = "push --force-with-lease --force-if-includes";

      undo = "reset HEAD~1 --mixed"; # Undo last commit

      brb = "stash push --staged"; # Leave a branch temporarily. Staged files are stashed, while unstaged will travel with us to the other branch
      imback = "stash pop";

      gothru = "add --patch"; # See all changes and decide which ones to stage

      # Used like this to combine last three commits: `git combine 3 "awesome commit message here"`
      combine = ''!f() { git reset HEAD && git branch -D backup-before-combine && git branch backup-before-combine && git reset --soft HEAD~"$1" && git commit -m "$2"; }; f'';
      uncombine = "reset --soft backup-before-combine"; # Doesn't touch staged and unstaged files, just changes the commit history
    };
  };
}
