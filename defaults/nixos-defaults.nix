# common-sense options here
{
inputs,
config,
...
}:

{
  imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Important settings, never to change
  nix.settings.experimental-features = "nix-command flakes";
  users.users.username =
  {
    isNormalUser = true;
    description = "User Name";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  security.sudo.wheelNeedsPassword = false;

  environment.sessionVariables.FLAKE = "/etc/nixos";

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
}
