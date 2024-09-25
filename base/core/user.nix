{ hostVars, pkgs, ... }:

{
  users.users.${hostVars.username} =
  {
    isNormalUser = true;
    description = hostVars.fullName;

    hashedPassword = "$y$j9T$MGJ3p2bsJzeGrB6.3zN7s.$RobkJp7ROyz3FSS9nDqAp412hjhRuCv/GMaB7Swo8Y5";
    extraGroups = [ "wheel" ];
  };

  users.mutableUsers = false; # Makes it so we can only do password stuff via nixos, safer for not bricking system

  security.sudo.wheelNeedsPassword = false; # Passwordless sudo
}