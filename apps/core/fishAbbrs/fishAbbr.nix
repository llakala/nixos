{ config, ... }:

{

  hm.programs.fish.shellAbbrs =
  {
    cdn = "cd ${config.baseVars.configDirectory}";

    m = "man";
    py = "python";
    j = "java";

    src = "source";

    # Our custom program for managing which hunks are staged
    ghpc = "ghp && git commit";
    gfpc = "gfp && git commit";
    gkpc = "gkp && git commit";

  };

}
