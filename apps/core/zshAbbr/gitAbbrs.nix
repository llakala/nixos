{
  hm.programs.zsh.zsh-abbr.abbreviations =
  {
    g = "git";
    gst = "git status";
    gcl = "git clone";
    gin = "git init";
    gch = "git checkout";


    gad = "git add";
    gadn = "git add -AN"; # Add all untracked files
    gada = "git add .";

    gun = "git unstage"; # Alias of `git restore --staged`
    guna = "git unstage .";

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

    glg = "git log";
    glgp = "git log --patch";
    ghs = "git history"; # Same as `glgp`, just an alias for intuition

    gc = "git commit";
    gcm = "git commit -m \"%\"";

    gbr = "git pbranch"; # Call our alias for `git branch` that adds formatting
    gbrd = "git branch -d";

    gps = "git push";
    gpl = "git pull";
    gfs = "git force";

    gsw = "git switch";
    gswm = "git switch main";
    gswma = "git switch master";
    gswc = "git switch -c";

    gswp = "git pswitch"; # Switch branches using custom alias with fzf. `p` at the end to differentiate from `gpsw`.

    grb = "git rebase";
    grbm = "git rebase main";
    grbma = "git rebase master";

    grbi = "git rebase -i HEAD~%"; # `grbi 2` will rebase from last 2 commits
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