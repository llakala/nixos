{
  vars,
  ...
}:

{

  programs.home-manager.enable = true;

  home =
  {
    username = vars.username;
    homeDirectory = vars.homeDirectory;
  };

  home.stateVersion = "23.11";

}