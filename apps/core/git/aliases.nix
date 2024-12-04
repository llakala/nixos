{
  hm.programs.git.aliases =
  {
    amend = "commit --amend --no-edit";
    reword = "commit --amend";
    force = "push --force-with-lease --force-if-includes";

    brb = "stash push --staged"; # Leave a branch temporarily. Staged files are stashed, while unstaged will travel with us to the other branch
    imback = "stash pop";

    wdiff = "diff --color-words";

    hire = "stage --patch"; # Stage specific changes, one by one
    fire = "restore --staged --patch"; # Unstage specific staged changes
    kill = "restore --patch"; # Undo an unstaged change

    history = "log --patch";

    stage = "git add .";
    unstage = "git restore --staged .";

    # Prettier formatting for `git branch`
    pbranch = "branch --sort=-committerdate --format ' %(objectname:short) |%(HEAD)%(align:22,left)%(refname:short)%(end) | %(align:14,right)%(committerdate:relative)%(end) %0a--------------------------------------------------'";
  };
}
