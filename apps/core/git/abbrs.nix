{ config, ... }:
{
  hm.programs.fish.shellAbbrs =

  # Error if we ever change shell
  assert config.features.abbreviations == "fish";
  {
    g = "git";
    gcl = "git clone";
    gin = "git init";

    # Most commonly-run git commands get two letters
    gs = "git status";
    gc = "git commit";

    # Alias of `git restore --staged`
    gn = "git unstage .";
    gl = "git log";
    gp = "git push";

    ga = "git add .";
    gac = "git commit .";

    # Staged changes
    gd = "git diff --staged";

    # Unstaged changes
    gdu = "git diff";

    gsw = "git switch";
    gswc = "git switch -c";
    gswm = "git switch main";
    gswma = "git switch master";

    gpl = "git pull";
    gplum = "git pull upstream main";
    gpluma = "git pull upstream master";

    # Force push via custom alias
    gfs = "git force";

    grw = "git reword";

    # Get ready with me :3
    grwm = "git reword --message";

    gam = "git amend";
    gamp = "git amend --patch";

    # Add all new files
    ganf = "git add -AN";

    # Alias, unstage new file existence
    gunf = "git unstage-new-files";

    # Call our alias for `git branch` that adds formatting
    gbr = "git pbranch";
    gbrd = "git branch -d";

    # Switch branches using custom alias with fzf
    gswp = "git pswitch";

    # Using our custom patch-based git aliases

    # Add staged changes
    ghr = "git hire";

    # Unstage staged changes via patch
    gfr = "git fire";

    # Delete unstaged changes
    gkl = "git kill";

    # Same as `git log --patch`, just an alias for intuition
    ghs = "git history";

    grb = "git rebase";
    grbm = "git rebase main";
    grbma = "git rebase master";

    # `grbi 2` will rebase from last 2 commits
    grbi =
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
