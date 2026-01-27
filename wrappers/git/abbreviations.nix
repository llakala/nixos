# I try to use single-letter abbrs for things I do all the time. Stuff like
# `git status`, `git commit`, etc, don't need a `g` prefix. However, anything
# requiring 2+ letters, like `am`, should keep the `g` prefix. This balances
# quick access and memorability for weird abbrs.
{
  g = "git";
  s = "git status";
  gcl = "git clone";

  a = "git add .";
  n = "git unstage ."; # Alias of `git restore --staged`
  gan = "git add -AN"; # Add all new files
  gun = "git unstage-new-files"; # Alias, unstage new file existence

  c = "git commit";
  gac = "git commit .";
  grw = "git reword";
  gam = "git amend";

  d = "git diff --staged"; # Staged changes
  gdu = "git diff"; # Unstaged changes

  l = "git log";
  ghs = "git history"; # Same as `git log --patch`, just an alias for intuition

  p = "git push";
  gfs = "git force"; # Force push via custom alias

  gpl = "git pull";
  gplum = "git pull upstream main";
  gpluma = "git pull upstream master";

  gsw = "git switch";
  gswc = "git switch -c";
  gswp = "git pswitch"; # Switch branches using custom alias with fzf
  gswm = "git switch main";
  gswma = "git switch master";
  gsh = "git stash --staged";
  gshu = "git stash --keep-index --include-untracked"; # Stash everything that isn't staged
  gsha = "git stash --include-untracked"; # Stash everything
  gshl = "git stash list -p";
  gshp = "git stash pop";

  gbr = "git pbranch"; # Call our alias for `git branch` that adds formatting
  gbrd = "git branch -d";

  grb = "git rebase";
  grbm = "git rebase main";
  grbma = "git rebase master";

  # `grbi 2` will rebase from last 2 commits
  grbi = {
    setCursor = true;
    expansion = "git rebase -i HEAD~%";
  };

  grbc = "git rebase --continue";
  grba = "git rebase --abort";

  grbum = "git rebase upstream/main";
  grbuma = "git rebase upstream/master";

  gcp = "git cherry-pick";
  gcpc = "git cherry-pick --continue";
  gcpa = "git cherry-pick --abort";

  grp = "git rev-parse";
  gmt = "git mergetool";
  gch = "git checkout";

  # Using our custom patch-based git aliases
  ghr = "git hire"; # Add staged changes
  gfr = "git fire"; # Unstage staged changes via patch
  gkl = "git kill"; # Delete unstaged changes

  gud = "git undo";
  grd = "git redo";
}
