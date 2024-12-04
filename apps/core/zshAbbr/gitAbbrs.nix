{
  hm.programs.zsh.zsh-abbr.abbreviations = 
  {
    g = "git";
    gst = "git status";
    glg = "git log";
    gan = "git add -AN"; # Add all untracked files
    gcl = "git clone";
    gin = "git init";

    gc = "git commit";
    gcm = "git commit -m \"%\"";

    gbr = "git branch";
    gbrd = "git branch -d";

    gps = "git push";
    gpl = "git pull";

    gsw = "git switch";
    gswm = "git switch main";
    gswma = "git switch master";
    gswc = "git switch -c";

    grb = "git rebase";
    grbi = "git rebase -i HEAD~%"; # `grbi 2` will rebase from last 2 commits
    grbc = "git rebase --continue";
    grba = "git rebase --abort";

    gstg = "git add ."; # Stage everything
    guns = "git restore --staged ."; # Unstage everything. Unfortunate name.

    # Use our custom `wdiff` alias for word-diff
    gdf = "git wdiff HEAD"; # Including both unstaged and staged changes
    gdfs = "git wdiff --staged";
    gdfu = "git wdiff"; # Unstaged changes

    # Using our custom git aliases
    ghr = "git hire";
    ghrc = "git commit --patch";

    gfr = "git fire";
    gkl = "git kill";

    gfs = "git force";

    grw = "git reword";
    grwm = "git reword --message"; # Get ready with me :3

    gam = "git amend";
    gamp = "git amend --patch";

    ghs = "git history";
  };
}