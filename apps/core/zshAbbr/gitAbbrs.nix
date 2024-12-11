{
  hm.programs.zsh.zsh-abbr.abbreviations = 
  {
    g = "git";
    gst = "git status";
    gan = "git add -AN"; # Add all untracked files
    gcl = "git clone";
    gin = "git init";

    glg = "git log";
    glgp = "git log --patch";
    ghs = "git history"; # Same as `glgp`, just an alias for intuition



    gc = "git commit";
    gcm = "git commit -m \"%\"";

    gbr = "git pbranch"; # Call our alias for `git branch` that adds formatting
    gbrd = "git branch -d";

    gps = "git push";
    gpl = "git pull";

    gsw = "git switch";
    gswm = "git switch main";
    gswma = "git switch master";
    gswc = "git switch -c";

    grb = "git rebase";
    grbm = "git rebase main";
    grma = "git rebase master";
    grbi = "git rebase -i HEAD~%"; # `grbi 2` will rebase from last 2 commits
    grbc = "git rebase --continue";
    grba = "git rebase --abort";

    grst = "git reset";
    grsth = "git reset --hard";

    gall = "git add ."; # Stage everything
    guns = "git restore --staged ."; # Unstage everything. Unfortunate name.

    gdf = "git diff HEAD"; # Including both unstaged and staged changes
    gdfs = "git diff --staged";
    gdfu = "git diff"; # Unstaged changes

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
  };
}