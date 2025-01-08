{
  programs.direnv =
  {
    enable = true;
    silent = true;
  };

  hm.programs.git.extraConfig =
  {
    core.excludesFile = "~/.config/git/ignore";
  };

  hm.programs.git.ignores = # Writes to above path
  [
    ".envrc"
    ".direnv/"
  ];

}