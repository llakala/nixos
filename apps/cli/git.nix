{
  vars,
  ...
}:

{
  hm.programs.git =
  {
    enable = true;
    userName = vars.fullName; # Full name associated with commits
    userEmail = "78693624+quatquatt@users.noreply.github.com"; # github noreply email

    extraConfig =
    {
      pull.ff = "only";

      push.autoSetupRemote = true;
      push.useForceIfIncludes = true;
    };

    aliases =
    {
      oops = "commit --amend --no-edit";
      reword = "commit --amend";
      force = "push --force-with-lease --force-if-includes";
    };
  };
}