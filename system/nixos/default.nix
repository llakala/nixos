# common-sense options here
{
  config,
  vars,
}:

{
  imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./bootloader.nix
    ./user.nix
  ];

  # Important settings, never to change
  nix.settings.experimental-features = "nix-command flakes";

  environment.sessionVariables.FLAKE = vars.configDirectory;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
}
