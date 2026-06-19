let
  sources = import ./other/npins;
  pkgs = import sources.nixpkgs { config.allowUnfree = true; }; # Read impurely from `builtins.currentSystem`
  nixosSystem = import "${sources.nixpkgs}/nixos/lib/eval-config.nix";

  # Variables that apply to all hosts, to query things like the username without
  # hardcoding it within config
  baseVars = import ./other/baseVars.nix;

  myLib = import ./other/myLib/default.nix { inherit pkgs; };
  wrappers = import ./wrappers.nix { inherit pkgs sources myLib; };

  mkHost = hostVars: nixosSystem {
    inherit pkgs;
    specialArgs = {
      self = {
        inherit sources baseVars hostVars wrappers;
        packages = import ./packages.nix { inherit pkgs sources myLib wrappers; };
      };
    };

    # I use a custom recursive importer, that will "expand" any folders in this
    # list to all the files within that folder.
    modules = myLib.recursivelyImport [
      ./common
      ./hosts/${hostVars.hostname}
      ./other/nixosModules
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
  palpot = mkHost {
    hostname = "palpot";
    configDirectory = "/home/${baseVars.username}/Documents/projects/nixos";
    stateVersion = "25.05";
    touchpadName = "Libinput/1739/53227/VEN_06CB:00 06CB:CFEB Touchpad";
    scalingFactor = 1;
  };
}
