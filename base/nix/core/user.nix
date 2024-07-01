{
hostVars,
...
}:

{
  users.users.${hostVars.username} =
  {
    isNormalUser = true;
    description = hostVars.fullName;

    initialPassword = " ";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  security.sudo.wheelNeedsPassword = false;
}