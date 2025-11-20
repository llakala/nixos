let
  sources = import ./various/npins;
  pkgs = import sources.nixpkgs { }; # Read impurely from `builtins.currentSystem`
  nixosSystem = import "${sources.nixpkgs}/nixos/lib/eval-config.nix";

  # Variables that apply to all hosts, to query things like the username without
  # hardcoding it within config
  baseVars = import ./various/baseVars.nix;

  myLib = import ./various/myLib/default.nix { inherit pkgs; };

  mkHost = hostVars: nixosSystem {
    specialArgs = {
      inherit sources myLib baseVars hostVars;
      self = {
        packages = import ./packages.nix { inherit pkgs sources myLib; };
        wrappers = import ./wrappers { inherit pkgs sources myLib; };
      };
    };

    # I use a custom recursive importer, that will "expand" any folders in this
    # list to all the files within that folder.
    modules = myLib.recursivelyImport [
      ./programs
      ./system
      ./various/nixosModules

        # To handle differences between hosts, each host provides a folder with
        # config specific to them
      ./various/hosts/${hostVars.hostname}/config
      ./various/hosts/${hostVars.hostname}/hardware-configuration.nix
    ];
  };

in {
  # Each host passes something we call hostVars, which are automatically passed
  # into `specialArgs`. If two hosts only differ by their scaling factor, we
  # don't have to duplicate the configuration - we just use the dynamic value of
  # hostVars.scalingFactor!
  desktop = mkHost {
    hostname = "desktop";
    configDirectory = "/home/${baseVars.username}/Documents/projects/nixos";
    stateVersion = "24.05";
    mouseName = "Libinput/1133/16500/Logitech G305";
    scalingFactor = 1;
  };

  framework = mkHost {
    hostname = "framework";
    configDirectory = "/etc/nixos";
    stateVersion = "24.05";
    scalingFactor = 2;
  };

  palpot = mkHost {
    hostname = "palpot";
    configDirectory = "/home/${baseVars.username}/Documents/projects/nixos";
    stateVersion = "25.05";
    touchpadName = "Libinput/1739/53227/VEN_06CB:00 06CB:CFEB Touchpad";
    scalingFactor = 1;
  };

  iso = mkHost {
    hostname = "iso";
    configDirectory = "/etc/nixos";
    stateVersion = "24.11";
    scalingFactor = 1;
  };
}
