{
  config,
  vars,
  hostVars,
  ...
}:

{

  nix =
  {
    channel.enable = false;
    nixPath =
    [
      "home-manager=${vars.configDirectory}/defaults"
      "nixpkgs=flake:nixpkgs"
    ];
    gc.automatic = true;
  };

  nix.settings =
  {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
    connect-timeout = 5;
    log-lines = 25; # Show more lines if error happens
    warn-dirty = false; # No warnings if git isn't pushed
  };




  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = hostVars.stateVersion;
}