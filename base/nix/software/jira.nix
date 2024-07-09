{hostVars, pkgs, ...}:

{
  services.jira =
  {
    enable = true;
    user = hostVars.username;
    
  };
}