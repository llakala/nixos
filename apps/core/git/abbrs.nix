{ config, ... }:
{
  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; # Error if we ever change shell
  {
    g = "git";
    gcl = "git clone";
    gin = "git init";

    # Most commonly-run git commands get two letters
    gs = "git status";
    gc = "git commit";
    gn = "git unstage ."; # Alias of `git restore --staged`
    gl = "git log";
    gp = "git push";

    ga = "git add .";
    gac = "git commit .";

    gd = "git diff --staged"; # Staged changes
    gdu = "git diff"; # Unstaged changes

    gsw = "git switch";
    gswc = "git switch -c";
    gswm = "git switch main";
    gswma = "git switch master";

    gpl = "git pull";
    gplum = "git pull upstream main";
    gpluma = "git pull upstream master";

    gfs = "git force"; # Force push via custom alias

    grw = "git reword";
    grwm = "git reword --message"; # Get ready with me :3

    gam = "git amend";
    gamp = "git amend --patch";

    ganf = "git add -AN"; # Add all new files
    gunf = "git unstage-new-files"; # Alias, unstage new file existence

    gbr = "git pbranch"; # Call our alias for `git branch` that adds formatting
    gbrd = "git branch -d";

    # Switch branches using custom alias with fzf
    gswp = "git pswitch";

    # Using our custom patch-based git aliases
    ghr = "git hire"; # Add staged changes
    gfr = "git fire"; # Unstage staged changes via patch
    gkl = "git kill"; # Delete unstaged changes

    ghs = "git history"; # Same as `git log --patch`, just an alias for intuition

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

    grm = "git remote -v";
    grmau = "git remote add upstream";

    gfe = "git fetch";
    gfeu = "git fetch upstream";

    gcm =
    {
      setCursor = true;
      expansion = "git commit -m \"%\"";
    };
  };
}
