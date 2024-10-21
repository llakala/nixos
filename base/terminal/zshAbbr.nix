{

  hm.programs.zsh.zsh-abbr =
  {
    enable = true;
    abbreviations =
    {
      g = "git";
      gst = "git status";
      gsw = "git switch";
      gcm = "git commit -m";
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
