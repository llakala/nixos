{ self, nixpkgs, ... } @ inputs:

let
  lib = nixpkgs.lib;

  # It's a personal repo, not supporting other systems right now
  supportedSystems = lib.singleton "x86_64-linux";

  forAllSystems = function: lib.genAttrs
    supportedSystems
    (system: function nixpkgs.legacyPackages.${system});

  # My custom lib functions, stored in a separate repo.
  # This instance only holds pure functions, and isn't passed
  # to anywhere. We just use it when we need a custom function,
  # but don't have system access.
  pureLlakaLib = inputs.llakaLib.pureLib;

  mkNixos = hostname:
  { system }: let llakaLib = inputs.llakaLib.fullLib.${system};
  in lib.nixosSystem
  {
    specialArgs =
    {
      inherit inputs llakaLib self;

      # We never use unfree packages from unstable, to avoid re-instantiating nixpkgs
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    };

    # Use custom function that grabs all files within a folder and filters out non-nix files
    modules = llakaLib.resolveAndFilter
    [
      ./config/core
      ./config/features
      ./config/gnome
      ./config/baseVars.nix

      ./apps/core
      ./apps/dev
      ./apps/extras
      ./apps/gui

      ./hosts/${hostname}/config
      ./hosts/${hostname}/hardware-configuration.nix
      ./hosts/${hostname}/${hostname}Vars.nix

      self.nixosModules.default
    ];
  };

in
{
  # Run mkNixos for each host. mapAttrs is magic here.
  #
  # mkNixos expects two arguments - a string representing the hostname,
  # and an attrset with a value for the key `system`. An example call of
  # `mkNixos` without `mapAttrs` would be:
  # `mkNixos "framework" { system = "x86_64-linux"; }`.
  #
  # Now, `mapAttrs` is very simple: it takes `key = value` and turns it
  # into `key value`.
  #
  # This is useful because `framework.system = val;` is just syntactic
  # sugar for `framework = { system = val; }` so, `mapAttrs` receives
  # that unsugared and separates the key and the value, to:
  # `"framework" { system = "x86_64-linux"; }`.
  #
  # Which, if you remember the mkNixos description, is exactly what we
  # wanted!
  nixosConfigurations = builtins.mapAttrs mkNixos
  {
    framework.system = "x86_64-linux";

    desktop.system = "x86_64-linux";

    iso.system = "x86_64-linux";
    temp.system = "x86_64-linux";
  };

  # Call all packages automatically in directory, while letting packages refer to each other
  # via custom lib function
  legacyPackages = forAllSystems
  (
    pkgs: let llakaLib = inputs.llakaLib.fullLib.${pkgs.system};
    in llakaLib.collectDirectoryPackages
    {
      inherit pkgs;
      directory = ./extras/packages;

      extras = { inherit llakaLib; }; # So custom packages can rely on llakaLib
    }
  );

  # for easier access, this lets us add all our modules by just importing self.nixosModules.default
  nixosModules.default =
  {
    imports = pureLlakaLib.resolveAndFilter
    [
      ./extras/nixosModules
    ];
  };

  formatter = forAllSystems
  (
    pkgs: pkgs.nixfmt-rfc-style
  );
}
