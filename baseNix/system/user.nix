{
hostVars,
...
}:

{
  users.users.${hostVars.username} =
  {
    isNormalUser = true;
    description = hostVars.fullName;
    
    extraGroups = [ "networkmanager" "wheel" ];
  };

  security.sudo.wheelNeedsPassword = false;
}