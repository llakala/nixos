{ config, ... }:
{
  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; # Error if we ever change shell
  {
    g = "git";
    cl = "git clone";

    s = "git status";

    a = "git add .";
    n = "git unstage ."; # Alias of `git restore --staged`

    c = "git commit";
    ac = "git commit .";
    rw = "git reword";
    am = "git amend";

    d = "git diff --staged"; # Staged changes
    du = "git diff"; # Unstaged changes. Use `command du` for actual `du`

    p = "git push";
    pl = "git pull";
    fs = "git force"; # Force push via custom alias
    plum = "git pull upstream main";
    pluma = "git pull upstream master";

    l = "git log";
    hs = "git history"; # Same as `git log --patch`, just an alias for intuition

    an = "git add -AN"; # Add all new files
    un = "git unstage-new-files"; # Alias, unstage new file existence

    sw = "git switch";
    swc = "git switch -c";
    swp = "git pswitch"; # Switch branches using custom alias with fzf
    swm = "git switch main";
    swma = "git switch master";

    shs = "git stash --staged";
    shu = "git stash --keep-index --include-untracked"; # Stash everything that isn't staged
    sha = "git stash --include-untracked"; # Stash everything
    shp = "git stash pop";

    br = "git pbranch"; # Call our alias for `git branch` that adds formatting
    brd = "git branch -d";

    rbm = "git rebase main";
    rbma = "git rebase master";

    # `rbi 2` will rebase from last 2 commits
    rbi =
    {
      setCursor = true;
      expansion = "git rebase -i HEAD~%";
    };

    rbc = "git rebase --continue";
    rba = "git rebase --abort";

    rbum = "git rebase upstream/main";
    rbuma = "git rebase upstream/master";

    # Using our custom patch-based git aliases
    hr = "git hire"; # Add staged changes
    fr = "git fire"; # Unstage staged changes via patch
    kl = "git kill"; # Delete unstaged changes
  };
}
