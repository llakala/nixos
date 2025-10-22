let
  sources = import ./various/npins;
  nixosSystem = import "${sources.nixpkgs}/nixos/lib/eval-config.nix";

  # Variables that apply to all hosts, for querying things like the username
  # without hardcoding it within config
  baseVars = import ./various/baseVars.nix;

  # For a given host, call `lib.nixosSystem`, passing the provided parameters.
  #
  # To handle differences between hosts,we auto-import some files from
  # `extras/hosts/${hostname}`. This locks every host into providing a hardware
  # configuration, as well as a folder with generic extra config.
  #
  # The parameters mainly consist of hostVars, which are autocally passed nto
  # `specialArgs`. This lets us handle slight differences between hosts. If two
  # hosts only differ by their scaling factor, we don't have to duplicate the
  # configuration - we just use the dynamic value of `hostVars.scalngFactor`! I
  # try to keep most of my config applicable to all hosts, so this is a great
  # way of keeping that purity.
  mkHost = { system, hostVars }: let
    pkgs = import sources.nixpkgs { inherit system; };
    myLib = import ./various/myLib/default.nix { inherit pkgs; };
  in nixosSystem {
    # Technically unnecessary, but keeps our impl pure
    inherit system;

    specialArgs = {
      inherit sources myLib baseVars hostVars;
      self.packages = import ./packages.nix { inherit pkgs sources; };
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
    system = "x86_64-linux";
    hostVars = {
      hostname = "desktop";
      configDirectory = "/home/${baseVars.username}/Documents/projects/nixos";
      stateVersion = "24.05";
      mouseName = "Libinput/1133/16500/Logitech G305";
      scalingFactor = 1;
    };
  };

  framework = mkHost {
    system = "x86_64-linux";
    hostVars = {
      hostname = "framework";
      configDirectory = "/etc/nixos";
      stateVersion = "24.05";
      scalingFactor = 2;
    };
  };

  palpot = mkHost {
    system = "x86_64-linux";
    hostVars = {
      hostname = "palpot";
      configDirectory = "/home/${baseVars.username}/Documents/projects/nixos";
      stateVersion = "25.05";
      touchpadName = "Libinput/1739/53227/PNP0C50:00 06CB:CFEB Touchpad";
      scalingFactor = 1;
    };
  };
  iso = mkHost {
    system = "x86_64-linux";
    hostVars = {
      hostname = "iso";
      configDirectory = "/etc/nixos";
      stateVersion = "24.11";
      scalingFactor = 1;
    };
  };
}
