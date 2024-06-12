{
  hostVars,
  ...
}:

{

  programs.home-manager.enable = true;

  home =
  {
    username = hostVars.username;
    homeDirectory = hostVars.homeDirectory;
    stateVersion = "23.11";
  };
}