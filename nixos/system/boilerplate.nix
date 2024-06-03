{
  config,
  vars,
  ...
}:

{
  nix.settings.experimental-features = "nix-command flakes";

  environment.sessionVariables.FLAKE = vars.configDirectory;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.${vars.username} =
  {
    isNormalUser = true;
    description = vars.fullName;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "23.11";
}