{ config, ... }:

{

  hm.programs.fish.shellAbbrs =
  {
    cdn = "cd ${config.baseVars.configDirectory}";

    m = "man";
    py = "python";
    j = "java";

    src = "source";
  };

}
