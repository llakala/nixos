{
  features.direnv = "nix-direnv"; # Change if we ever stop using lorri

  programs.direnv = {
    enable = true;
    silent = true;

    nix-direnv.enable = true;
  };

  hm.programs.git.extraConfig = {
    core.excludesFile = "~/.config/git/ignore";
  };

  # Writes to above path
  hm.programs.git.ignores = [
    ".direnv/"
  ];

}
