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
      pull.rebase = true; # Merging is evil
      help.autocorrect = 50; # You know what I meant, git, but give me 5 seconds to stop you
      push.autoSetupRemote = true;
    };
  };
}