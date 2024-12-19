{
  hm.programs.git.aliases =
  {
    amend = "commit --amend --no-edit";
    reword = "commit --amend";
    force = "push --force-with-lease --force-if-includes";

    brb = "stash push --staged"; # Leave a branch temporarily. Staged files are stashed, while unstaged will travel with us to the other branch
    imback = "stash pop";


    unstage = "restore --staged"; # Unstage changes
    goback = "restore"; # Undo unstaged changes

    # Patch versions of add, unstage, and goback
    hire = "add --patch";
    fire = "unstage --patch";
    kill = "goback --patch";

    history = "log --patch";

    # Inverse of `--intent-to-add` from `git add`. Unadd the existence of all new files.
    # Ideally this would be patch-based, but we'll take what we can get
    # Can't take credit for this, see https://stackoverflow.com/questions/12994197/how-to-remove-only-intent-to-add-files-from-index-in-git
    unstage-new-files = "!git diff --name-only --diff-filter=A -z | git restore --staged -q --pathspec-file-nul --pathspec-from-file=- > /dev/null 2>&1";

    # Prettier formatting for `git branch`
    pbranch = "branch --sort=-committerdate --format '%(color:dim white)%(objectname:short)%(color:reset) |%(color:green)%(HEAD)%(color:bold yellow)%(align:22,left)%(refname:short)%(end)%(color:reset) | %(color:cyan)%(align:14,right)%(committerdate:relative)%(end)%(color:reset)%0a--------------------------------------------------'";

    # Switch to branch using fzf. Reference links below
    # https://esc.sh/blog/switch-git-branches-fzf/
    # https://github.com/erees1/dotfiles/blob/b29a94e/git/aliases.zsh#L85-L97
    pswitch = "!git switch $(git pbranch --color | fzf --ansi | cut -d '|' -f2 | cut -c 2-)";
  };
}
