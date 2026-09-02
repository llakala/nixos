# I try to use single-letter abbrs for things I do all the time. Stuff like
# `git status`, `git commit`, etc, don't need a `g` prefix. However, anything
# requiring 2+ letters, like `am`, should keep the `g` prefix. This balances
# quick access and memorability for weird abbrs.
{
  g = "git";
  s = "git status";
  gcl = "git clone";

  a = "git add -u";
  aa = "git add -A";
  n = "git unstage ."; # Alias of `git restore --staged`
  gan = "git add -AN"; # Add all new files
  gun = "git unstage-new-files"; # Alias, unstage new file existence

  c = "git commit";
  gac = "git commit -p";
  grw = "git reword";
  gam = "git amend";

  du = "git diff";
  ds = "git diff --staged";
  dtu = "git difftool";
  dts = "git difftool --staged";

  l = "git log";
  glp = "git log -p";
  gso = "git show";

  p = "git push";
  gfs = "git force"; # Force push via custom alias
  gfe = "git fetch";

  gpl = "git pull";
  gplum = "git pull upstream main";
  gpluma = "git pull upstream master";

  gsw = "git switch";
  gswc = "git switch -c";
  gsw- = "git switch -";
  gswp = "git pswitch"; # Switch branches using custom alias with fzf
  gswm = "git switch main";
  gswma = "git switch master";

  gsh = "git stash";
  gshs = "git stash --staged"; # Staged changes
  gshu = "git stash --keep-index"; # Unstaged changes
  gsha = "git stash --include-untracked"; # Stash everything
  gshl = "git stash list -p";
  gshp = "git stash pop";
  gshd = "git stash drop";

  gbr = "git pbranch"; # Call our alias for `git branch` that adds formatting
  gbrd = "git branch -d";
  gbrD = "git branch -D";
  gbrm = "git branch --merged";

  grb = "git rebase";
  grbm = "git rebase main";
  grbma = "git rebase master";
  grbum = "git rebase upstream/main";
  grbuma = "git rebase upstream/master";
  grbc = "git rebase --continue";
  grba = "git rebase --abort";

  grbi = "git rebase -i";
  grbim = "git rebase -i main";
  grbima = "git rebase -i master";
  grbium = "git rebase -i upstream/main";
  grbiuma = "git rebase -i upstream/master";
  grbin = {
    setCursor = true;
    expansion = "git rebase -i HEAD~%";
  };

  gcp = "git cherry-pick";
  gcpc = "git cherry-pick --continue";
  gcpa = "git cherry-pick --abort";

  grv = "git revert";
  grvc = "git revert --continue";
  grva = "git revert --abort";

  gre = "git reset";
  greh = "git reset --hard";
  grem = "git reset --mixed";
  gres = "git reset --soft";

  gch = "git checkout";
  gchum = "git checkout upstream/main";
  gchuma = "git checkout upstream/master";
  gch- = "git checkout -";

  grp = "git rev-parse";
  grf = "git reflog";
  grm = "git remote -v";
  gmt = "git mergetool";

  # Using our custom patch-based git aliases
  ghr = "git hire"; # Add staged changes
  gfr = "git fire"; # Unstage staged changes via patch
  gkl = "git kill"; # Delete unstaged changes

  gud = "git undo";
  grd = "git redo";
}
