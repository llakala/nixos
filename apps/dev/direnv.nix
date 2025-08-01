{
  features.direnv = "lorri"; # Change if we ever stop using lorri

  programs.direnv =
  {
    enable = true;
    silent = true;

    nix-direnv.enable = true;
  };

  # Sometimes fails - run `systemctl restart --user lorri` to fix
  services.lorri =
  {
    enable = true;
  };


  # Makes Nix not get rid of stuff direnv might be using, for better caching
  nix.settings =
  {
    keep-derivations = true;
    keep-outputs = true;
  };
}
