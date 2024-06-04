{

}:

{
  users.users.${vars.username} =
  {
    isNormalUser = true;
    description = vars.fullName;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  security.sudo.wheelNeedsPassword = false;
}