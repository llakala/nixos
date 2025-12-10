{ inputs }:
let
  inherit (inputs.nixpkgs) lib pkgs;
  lessWrapper = inputs.less {};
in
inputs.gh.iniConfig
// inputs.less.iniConfig
// {
  user = {
    name = "Eman Resu";
    email = "78693624+quatquatt@users.noreply.github.com";
  };

  init.defaultBranch = "main";
  branch.sort = "-committerdate";

  commit.verbose = true; # Show changes when writing commit message so we remember what we changed
  status.showUntrackedFiles = "all";

  # File only contains a single newline, so the comment below a commit giving
  # instructions gets pushed down a line, and `ip` motions work normally!
  commit.template = "${./template}";

  rerere.enabled = true;
  rebase.autoSquash = true; # Treat commits with prepend messages (squash! fixup!) as they should be

  diff.algorithm = "histogram";
  diff.renames = "copies"; # Be as smart for renames as possible
  diff.colorMoved = true;
  diff.wsErrorHighlight = "all"; # Highlight all whitespace errors, not just new ones

  # TODO: move into diff-so-fancy module once infrec is fixed
  interactive.diffFilter = "diff-so-fancy --patch";
  pager.diff = "diff-so-fancy | ${lib.getExe lessWrapper} -+F"; # Disable quit-if-one-screen for diffs
  diff-so-fancy.markEmptyLines = false; # So nothing else looks like `red reverse`

  apply.whitespace = "warn";

  pull.ff = "only"; # Prevent merging if changes are trivial, but if they're not, require an explicit merge
  push.autoSetupRemote = true;
  push.useForceIfIncludes = true;
  push.default = "current"; # Only push current branch, and don't force-push everything when force pushing

  log.abbrevCommit = true; # Show short version of commit hashes by default
  log.follow = true;
  log.date = "format:%I:%M %p%Z %a %b %-d %Y"; # a la "01:29 AM Wed Dec 3 2025"

  # Slightly modified version of the default log format, to just add color and
  # the relative date. If you'd like to see what the default is so you can
  # customize it, I have a reproduction up at https://www.reddit.com/r/git/comments/18szkj9/comment/ns109r0
  format.pretty = "format:commit %C(auto)%h%d%nAuthor: %C(brightgreen)%an%Creset %C(dim normal)<%ae>%C(auto)%nDate:   %C(brightblue)%ad%C(auto) (%C(blue)%ar%C(auto))%n%n%w(76,4,4)%B%-%n";

  merge.conflictstyle = "diff3";
  merge.directoryRenames = true; # Renamed directories don't cause a merge conflict

  merge.tool = "meld";
  mergetool.meld = {
    path = lib.getExe pkgs.meld;
    useAutoMerge = true;
  };

  alias = {
    amend = "commit --amend --no-edit";
    reword = "commit --amend --only"; # --only means staged changes aren't included
    force = "push --force-with-lease --force-if-includes";

    unstage = "restore --staged";

    # --soft is needed - means that `undo` will put the undone changes into
    # staging, and `redo` will commit only the staged changes you just undid.
    # Note that redo doesn't work when done multiple times - I did some
    # stackoverflow searching, and achieving this is more complicated than is
    # worth it to me
    undo = "reset --soft HEAD~";
    redo = "reset --soft ORIG_HEAD";

    # Patch versions for staging, unstaging, and restoring changes
    hire = "add --patch";
    fire = "restore --staged --patch";
    kill = "restore --patch";

    history = "log --patch";

    # Inverse of `--intent-to-add` from `git add`. Unadd the existence of all new files.
    # I make a modification to also unstage deleted files, see my post in the conversation
    # https://stackoverflow.com/questions/12994197/how-to-remove-only-intent-to-add-files-from-index-in-git
    unstage-new-files = "!cat <(git diff --name-only --diff-filter=A -z) <(git diff --staged --name-only --diff-filter=D -z) | git restore --staged -q --pathspec-file-nul --pathspec-from-file=- >/dev/null 2>&1";

    # Prettier formatting for `git branch`
    pbranch = "branch --sort=-committerdate --format '%(color:dim white)%(objectname:short)%(color:reset) |%(color:green)%(HEAD)%(color:bold yellow)%(align:28,left)%(refname:short)%(end)%(color:reset) | %(color:cyan)%(align:14,right)%(committerdate:relative)%(end)'";

    # Switch to branch using fzf. Reference links below
    # https://esc.sh/blog/switch-git-branches-fzf/
    # https://github.com/erees1/dotfiles/blob/b29a94e/git/aliases.zsh#L85-L97
    pswitch = # bash
    ''
      !git pbranch --color | \
      fzf --ansi --delimiter='\|' --preview-window='bottom' \
      --preview='echo {s2} | cut -c 2- | xargs git show | diff-so-fancy' | \
      cut -d '|' -f2 | cut -c 2- | xargs git switch
    '';
  };
}
