{
  hostVars,
  vars,
  ...
}:

{
  programs.git =
  {
    userName = hostVars.fullName;
    userEmail = hostVars.userEmail;

    extraConfig =
    {
      pull.rebase = true;
    };
  };
}