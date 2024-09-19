{
  hostVars,
  lib,
  ...
}:

{
  hm =
  {

    programs.home-manager =
    {
      enable = true;
    };

    home =
    {
      username = hostVars.username;
      homeDirectory = hostVars.homeDirectory;
      stateVersion = hostVars.stateVersion;
    };
  };

  home-manager.useUserPackages = lib.mkForce false; # Breaks everything
  
}