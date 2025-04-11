{ config, ... }:

{
  users.users.${config.hostVars.username} =
  {
    isNormalUser = true;
    description = config.baseVars.fullName;

    hashedPassword = "$y$j9T$MGJ3p2bsJzeGrB6.3zN7s.$RobkJp7ROyz3FSS9nDqAp412hjhRuCv/GMaB7Swo8Y5";
    extraGroups = [ "wheel" ];
  };

  # Makes it so we can only do password stuff via nixos, safer for not bricking system
  users.mutableUsers = false;

  security.sudo =
  {
    # No more passwordless sudo!
    wheelNeedsPassword = true;

    # If sudo itself had vulnerabilities (apparently has happened), you're still not
    # getting my calculus notes.
    execWheelOnly = true;
  };
}
