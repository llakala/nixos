{
  config,
  vars,
  ...
}:

{
  nix.settings.experimental-features = "nix-command flakes";

  environment.sessionVariables.FLAKE = vars.configDirectory;

  nix.channel.enable = false; 
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "23.11";
}