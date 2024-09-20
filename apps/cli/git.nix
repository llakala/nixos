{
  hostVars,
  vars,
  ...
}:

{
  hm.programs.git =
  {
    enable = true;
    userName = hostVars.fullName;
    userEmail = hostVars.userEmail;

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