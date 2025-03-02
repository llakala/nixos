{ self, ... } @ inputs:

let
  nixpkgs = inputs.nixpkgs;
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
      ./config/hyprland
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
  # Run mkNixos for each host
  nixosConfigurations = builtins.mapAttrs mkNixos
  {
    framework.system = "x86_64-linux";

    desktop.system = "x86_64-linux";

    iso.system = "x86_64-linux";
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
