{ config, ... }:
{

  environment.variables =
  {
    ABBR_SET_EXPANSION_CURSOR = 1; # Enable % syntax
  };

  hm.programs.zsh.zsh-abbr =
  {
    enable = true;
    abbreviations =
    {
      cdn = "cd ${config.baseVars.configDirectory}";

      g = "git";
      gst = "git status";
      gsw = "git switch";
      gcm = "git commit -m \"%\"";
      gps = "git push";
      glg = "git log";

      # Using our custom git aliases for staging, unstaging, and removing changes
      ghr = "git hire";
      gdm = "git demote";
      gfr = "git fire";

      nd = "nix develop";
    };
  };

}
