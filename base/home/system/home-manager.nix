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
  };



  home-manager.users.${hostVars.username} =
  {
    home.stateVersion = 23.11;
  }

}