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

      brb = "stash push --staged"; # Leave a branch temporarily. Staged files are stashed, while unstaged will travel with us to the other branch
      imback = "stash pop";
    };
  };
}