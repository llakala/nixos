{ config, ... }:

{

  hm.programs.fish.shellAbbrs =
  {
    cdn = "cd ${config.baseVars.configDirectory}";

    m = "man";
    py = "python";

    src = "source";

    gsp = "gasp"; # Our custom program for adding specific patches
  };

}