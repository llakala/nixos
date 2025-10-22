let
  sources = import ./various/npins;
  pkgs = import sources.nixpkgs { }; # Read impurely from `builtins.currentSystem`
  nixosSystem = import "${sources.nixpkgs}/nixos/lib/eval-config.nix";

  # Variables that apply to all hosts, to query things like the username without
  # hardcoding it within config
  baseVars = import ./various/baseVars.nix;

  myLib = import ./various/myLib/default.nix { inherit pkgs; };

  # For a given host, call `lib.nixosSystem`, passing the provided parameters.
  #
  # To handle differences between hosts,we auto-import some files from
  # `extras/hosts/${hostname}`. This locks every host into providing a hardware
  # configuration, as well as a folder with generic extra config.
  #
  # Each host passes something we call hostVars, which are automatically passed
  # into `specialArgs`. This lets us handle slight differences between hosts. If
  # two hosts only differ by their scaling factor, we don't have to duplicate
  # the configuration - we just use the dynamic value of hostVars.scalngFactor!
  # I try to keep most of my config applicable to all hosts, so this is a great
  # way of keeping that purity.
  mkHost = hostVars: nixosSystem {
    specialArgs = {
      inherit sources myLib baseVars hostVars;
      self = {
        packages = import ./packages.nix { inherit pkgs sources myLib; };
      };
    };

    # Any folders are automatically expanded to all the files within them
    modules = myLib.recursivelyImport [
      ./programs
      ./system
      ./various/nixosModules

      ./various/hosts/${hostVars.hostname}/config
      ./various/hosts/${hostVars.hostname}/hardware-configuration.nix
    ];
  };

in {
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
    touchpadName = "Libinput/1739/53227/PNP0C50:00 06CB:CFEB Touchpad";
    scalingFactor = 1;
  };

  iso = mkHost {
    hostname = "iso";
    configDirectory = "/etc/nixos";
    stateVersion = "24.11";
    scalingFactor = 1;
  };
}
