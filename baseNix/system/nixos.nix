{
  config,
  vars,
  hostVars,
  ...
}:

{
  nix.settings.experimental-features = "nix-command flakes";
  nix.channel.enable = false;


  nix.autoOptimizeStore = true;
  nix.nixPath =
  [
    "home-manager=${vars.configDirectory}/defaults"
    "nixpkgs=flake:nixpkgs"
  ];

  nixpkgs.config.allowUnfree = true;


  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = hostVars.stateVersion;
}