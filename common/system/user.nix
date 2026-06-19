{ self, ... }:

{
  users.users.${self.baseVars.username} = {
    isNormalUser = true;
    description = self.baseVars.fullName;

    hashedPassword = "$y$j9T$MGJ3p2bsJzeGrB6.3zN7s.$RobkJp7ROyz3FSS9nDqAp412hjhRuCv/GMaB7Swo8Y5";
    extraGroups = [ "wheel" ];
  };

  users.mutableUsers = false; # Makes it so we can only do password stuff via nixos, safer for not bricking system

  security.sudo = {
    # No more passwordless sudo!
    wheelNeedsPassword = true;

    # If sudo itself had vulnerabilities (apparently has happened), you're still not
    # getting my calculus notes.
    execWheelOnly = true;
  };
}
