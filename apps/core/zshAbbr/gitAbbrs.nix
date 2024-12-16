{
  hm.programs.zsh.zsh-abbr.abbreviations =
  {
    g = "git";
    gst = "git status";
    gan = "git add -AN"; # Add all untracked files
    gcl = "git clone";
    gin = "git init";
    gch = "git checkout";

    grm = "git remote -v";
    grmau = "git remote add upstream";

    gfe = "git fetch";
    gfeu = "git fetch upstream";

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

    gswp = "git pswitch"; # Switch branches using custom alias with fzf. `p` at the end to differentiate from `gpsw`.

    grb = "git rebase";
    grbm = "git rebase main";
    grbma = "git rebase master";

    grbi = "git rebase -i HEAD~%"; # `grbi 2` will rebase from last 2 commits
    grbc = "git rebase --continue";
    grba = "git rebase --abort";

    grbum = "git rebase upstream/main";
    grbuma = "git rebase upstream/master";

    grs = "git reset";
    grsh = "git reset --hard";

    gall = "git add ."; # Stage everything
    guns = "git restore --staged ."; # Unstage everything. Unfortunate name.

    gd = "git diff HEAD"; # Including both unstaged and staged changes
    gds = "git diff --staged";
    gdu = "git diff"; # Unstaged changes

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