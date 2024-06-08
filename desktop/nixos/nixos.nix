{
  config,
  vars,
  ...
}:

{
  nix.settings.experimental-features = "nix-command flakes";
  nix.channel.enable = false; 
  environment.sessionVariables.FLAKE = vars.configDirectory;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "23.11";
}