{ vars, ...}:

{
  environment.variables.FLAKE = vars.configDirectory;

  programs.nh =
  {
    enable = true;
  };
}