{ self, nixpkgs, ... } @ inputs:

let
  lib = nixpkgs.lib;

  # I occasionally work on a random mac and need devshell access, so the darwin
  # setup is nice. I don't guarantee any support for rebuilding with
  # aarch64-darwin, though.
  supportedSystems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];

  forAllSystems = function: lib.genAttrs
    supportedSystems
    (system: function nixpkgs.legacyPackages.${system});

  # My custom lib functions, stored in a separate repo.
  # This instance only holds pure functions, and isn't passed
  # to anywhere. We just use it when we need a custom function,
  # but don't have system access.
  pureLlakaLib = inputs.llakaLib.pureLib;

  # Variables that apply to all hosts, for querying things like the username
  # without hardcoding it within config
  baseVars = import ./extras/baseVars.nix;

  mkNixos = hostname: { system, hostVars }: let
    llakaLib = inputs.llakaLib.fullLib.${system};
  in lib.nixosSystem {
    specialArgs = {
      inherit inputs llakaLib self baseVars;
      hostVars = hostVars // { inherit hostname; };
    };

    # Use custom function that grabs all files within a folder and filters out
    # non-nix files. We choose to grab from subfolders when we want to have a
    # contract that some specific file actually exists.
    modules = llakaLib.resolveAndFilter [
      ./config

      ./apps
      ./extras/desktops

      ./extras/hosts/${hostname}/config
      ./extras/hosts/${hostname}/hardware-configuration.nix

      self.nixosModules.default
    ];
  };

in {
  # Run mkNixos for each host. mapAttrs is magic here.
  #
  # mkNixos expects two arguments - a string representing the hostname,
  # and an attrset with some extra parameters. An example call of
  # `mkNixos` without `mapAttrs` would be:
  # `mkNixos "framework" { system = "x86_64-linux"; }`.
  #
  # Now, `mapAttrs` is very simple: it takes `key = value` and turns it
  # into `key value`.
  #
  # This is useful because it lets us understand each host's key as its
  # hostname, and its value as extra parameters (like its system and extra
  # hostVars).
  #
  # Which, if you remember the mkNixos description, is exactly what we
  # wanted!
  nixosConfigurations =
    builtins.mapAttrs mkNixos
    (import ./extras/hosts.nix { inherit baseVars; });

  # Call all packages automatically in directory, while letting packages refer to each other
  # via custom lib function
  legacyPackages = forAllSystems (pkgs: let
    llakaLib = inputs.llakaLib.fullLib.${pkgs.system};
  in llakaLib.collectDirectoryPackages {
    inherit pkgs;
    directory = ./extras/packages;

    extras = { inherit llakaLib; }; # So custom packages can rely on llakaLib
  });

  # for easier access, this lets us add all our modules by just importing self.nixosModules.default
  nixosModules.default = {
    imports = pureLlakaLib.resolveAndFilter [
      ./extras/nixosModules
    ];
  };

  devShells = forAllSystems (pkgs: {
    default = import ./extras/shell.nix { inherit pkgs inputs; };
  });

  formatter = forAllSystems (pkgs:
    pkgs.nixfmt-rfc-style
  );
}
