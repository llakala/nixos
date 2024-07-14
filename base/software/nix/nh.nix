{ vars, ...}:

{
  environment.variables.FLAKE = vars.configDirectory;

  programs.nh =
  {
    enable = true;
  };

  programs.nh.clean =
  {
    enable = true;
    extraArgs = "--keep-since 30d";
  };
}