{ config, ... }:

{

  hm.programs.fish.shellAbbrs =
  {
    cdn = "cd ${config.baseVars.configDirectory}";

    m = "man";
    py = "python";

    src = "source";

    # Our custom program for managing which hunks are staged
    gsp = "gsap"; # Git Stage A Patch
    gup = "guap"; # Git Unstage A Patch
    gcp = "gcap"; # Git Clean A Patch
  };

}
