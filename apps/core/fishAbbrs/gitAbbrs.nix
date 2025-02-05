{
  hm.programs.fish.shellAbbrs =
  {
    g = "git";
    gcl = "git clone";
    gin = "git init";
    gch = "git checkout";

    # Most commonly-run git commands get two letters
    gs = "git status";
    gc = "git commit";
    ga = "git add .";
    gn = "git unstage ."; # Alias of `git restore --staged`
    gl = "git log";
    gp = "git push";

    ganf = "git add -AN"; # Add all new files
    gunf = "git unstage-new-files"; # Alias, unstage new file existence

    ggb = "git goback"; # Alias of `git restore`
    ggba = "git goback .";

    # Using our custom patch-based git aliases
    ghr = "git hire"; # Add staged changes
    ghrc = "git commit --patch";

    gfr = "git fire"; # Unstage staged changes via patch
    gkl = "git kill"; # Delete unstaged changes

    grm = "git remote -v";
    grmau = "git remote add upstream";

    gfe = "git fetch";
    gfeu = "git fetch upstream";

    glp = "git log --patch";
    ghs = "git history"; # Same as `glgp`, just an alias for intuition

    gcm =
    {
      setCursor = true;
      expansion = "git commit -m \"%\"";
    };

    gbr = "git pbranch"; # Call our alias for `git branch` that adds formatting
    gbrd = "git branch -d";

    gpl = "git pull";
    gplum = "git pull upstream main";
    gpluma = "git pull upstream master";

    gfs = "git force"; # Force push via custom alias

    gsw = "git switch";
    gswm = "git switch main";
    gswma = "git switch master";
    gswc = "git switch -c";

    gswp = "git pswitch"; # Switch branches using custom alias with fzf. `p` at the end to differentiate from `gpsw`.

    grb = "git rebase";
    grbm = "git rebase main";
    grbma = "git rebase master";

    grbi = # `grbi 2` will rebase from last 2 commits
    {
      setCursor = true;
      expansion = "git rebase -i HEAD~%";
    };

    grbc = "git rebase --continue";
    grba = "git rebase --abort";

    grbum = "git rebase upstream/main";
    grbuma = "git rebase upstream/master";

    gre = "git reset";
    greh = "git reset --hard";

    gd = "git diff HEAD"; # Including both unstaged and staged changes
    gds = "git diff --staged";
    gdu = "git diff"; # Unstaged changes

    grw = "git reword";
    grwm = "git reword --message"; # Get ready with me :3

    gam = "git amend";
    gamp = "git amend --patch";
  };
}