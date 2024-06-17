{
  config,
  vars,
  hostVars,
  ...
}:

{
  nix.settings.experimental-features = "nix-command flakes";
  nix.channel.enable = false;


  nix.settings.auto-optimise-store = true;
  nix.nixPath =
  [
    "home-manager=${vars.configDirectory}/defaults"
    "nixpkgs=flake:nixpkgs"
  ];


  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = hostVars.stateVersion;
}