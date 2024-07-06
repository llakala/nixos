{
  hostVars,
  vars,
  ...
}:

{
  programs.git =
  {
    enable = true;
    userName = hostVars.fullName;
    userEmail = hostVars.userEmail;

    extraConfig =
    {
      pull.rebase = true;
    };
  };
}