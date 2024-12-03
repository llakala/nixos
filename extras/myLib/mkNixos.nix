{ lib, myLib, inputs, self, ... }:

let
  config = # Config to be used for all `pkgs` instances created
  {
    allowUnfree = true;
  };

  mkNixos = hostname: { system }: # Function to be exported
  lib.nixosSystem
  {
    inherit system;

    specialArgs =
    {
      inherit inputs myLib self;

      pkgs = myLib.mkPkgs
      {
        inherit system config;
        unpatchedInput = inputs.nixpkgs;
        patches = [];
      };

      pkgs-unstable = myLib.mkPkgs
      {
        inherit system config;
        unpatchedInput = inputs.nixpkgs-unstable;
        patches = [];
      };
    };

    modules = myLib.resolveAndFilter # Use custom function that grabs all files within a folder and filters out non-nix files
    [
      ../../config/core
      ../../config/features
      ../../config/gnome
      ../../config/baseVars.nix

      ../../apps/core
      ../../apps/extras
      ../../apps/gui

      ../../hosts/${hostname}/config
      ../../hosts/${hostname}/hardware-configuration.nix
      ../../hosts/${hostname}/${hostname}Vars.nix

      self.nixosModules.default
    ];
  };
in
  mkNixos
