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
      help.autocorrect = 30; # You know what I meant, git, but give me 3 seconds to stop you
    };
  };
}