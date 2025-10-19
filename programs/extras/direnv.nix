{
  programs.direnv = {
    enable = true;
    silent = true;

    nix-direnv.enable = true;
  };

  hm.programs.git.settings = {
    core.excludesFile = "~/.config/git/ignore";
  };

  # Writes to above path
  hm.programs.git.ignores = [
    ".direnv/"
  ];
}
