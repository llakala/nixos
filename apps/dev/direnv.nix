{
  programs.direnv =
  {
    enable = true;
    silent = true;
  };


  # Makes Nix not get rid of stuff direnv might be using, for better caching
  nix.settings =
  {
    keep-derivations = true;
    keep-outputs = true;
  };

  programs.direnv.direnvrcExtra =
  ''
    use_flake()
    {
      watch_file flake.nix
      watch_file flake.lock

      watch_file packages/**/*.sh
      watch_file packages/**/*.nix

      eval "$(nix print-dev-env)"
    }
  '';

  hm.programs.git.extraConfig =
  {
    core.excludesFile = "~/.config/git/ignore";
  };

  hm.programs.git.ignores = # Writes to above path
  [
    ".direnv/"
  ];

}