{ config, ... }:

{
  features.abbreviationsProvider = "fish";

  hm.programs.fish.shellAbbrs =
  {
    cn = "cd ${config.baseVars.configDirectory}";

    m = "man";
    py = "python";
    j = "java";

    src = "source";
  };

}
