{
  hm.programs.git.aliases =
  {
    amend = "commit --amend --no-edit";
    reword = "commit --amend";
    force = "push --force-with-lease --force-if-includes";

    brb = "stash push --staged"; # Leave a branch temporarily. Staged files are stashed, while unstaged will travel with us to the other branch
    imback = "stash pop";

    hire = "stage --patch"; # Stage specific changes, one by one
    fire = "restore --staged --patch"; # Unstage specific staged changes
    kill = "restore --patch"; # Undo an unstaged change

    history = "log --patch";

    stage = "add .";
    unstage = "restore --staged .";

    # Prettier formatting for `git branch`
    pbranch = "branch --sort=-committerdate --format '%(color:dim white)%(objectname:short)%(color:reset) |%(color:green)%(HEAD)%(color:bold yellow)%(align:22,left)%(refname:short)%(end)%(color:reset) | %(color:cyan)%(align:14,right)%(committerdate:relative)%(end)%(color:reset)%0a--------------------------------------------------'";

    # Switch to branch using fzf. Reference links below
    # https://esc.sh/blog/switch-git-branches-fzf/
    # https://github.com/erees1/dotfiles/blob/b29a94e/git/aliases.zsh#L85-L97
    pswitch = "!git switch $(git pbranch --color | fzf --ansi | rg '(?<=\\|[* ])[^\\s|]+' --pcre2 -oN --color=never | head -n1)";
  };
}
