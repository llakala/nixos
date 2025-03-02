{ config, ... }:

{
  features.abbreviations = "fish";

  hm.programs.fish.shellAbbrs =
  {
    cn = "cd ${config.hostVars.configDirectory}";

    m = "man";
    py = "python";
    j = "java";

    src = "source";

    c = "cd";
  };

}
