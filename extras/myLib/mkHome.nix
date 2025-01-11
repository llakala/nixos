{ lib }:

let

  internals = # Functions for internal use, not exporting (proudly stolen from https://github.com/MattSturgeon/nix-config/blob/e98a93e/hosts/flake-module.nix)
  {
    atSignSplit = string:
      lib.splitString "@" string;

    guessUsername = userhost: # Grab everything before the @ in "username@hostname"
      if lib.length (internals.atSignSplit userhost ) == 2
      then lib.elemAt (internals.atSignSplit userhost) 0 # First value in list
      else throw "Invalid userhost format: ${userhost}. Expected format: username@hostname";

    guessHostname = userhost: # Grab everything after the @ in "username@hostname"
      if lib.length (internals.atSignSplit userhost ) == 2
      then lib.elemAt (internals.atSignSplit userhost) 1 # Second value in list
      else throw "Invalid userhost format: ${userhost}. Expected format: username@hostname";
  };

  mkHome = userhost: # Function to actually export
  {
    nixosConfigurations,
    username ? internals.guessUsername userhost,
    hostname ? internals.guessHostname userhost
  }:
    nixosConfigurations.${hostname}.config.home-manager.users.${username}.home; # allows me to independently switch my home environment without rebuilding my entire system


in
  mkHome