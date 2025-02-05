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
    hp = "ghp";
    fp = "gfp";
    kp = "gkp";

    hpc = "ghp && git commit";
    fpc = "gfp && git commit";
    kpc = "gkp && git commit";

  };

}
