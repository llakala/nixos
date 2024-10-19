{ lib, myLib, inputs, ... }:

let
  mkNixos = hostname: { system }: # Function to be exported
  lib.nixosSystem
    {
      inherit system;

    specialArgs =
    {
      inherit inputs myLib;

      pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; config.allowUnfree = true; };
    };

    modules = myLib.resolveAndFilter # Use custom function that grabs all files within a folder and filters out non-nix files
    [
      ../../base/core
      ../../base/features
      ../../base/gnome
      ../../base/terminal
      ../../base/baseVars.nix

      ../../apps/cli
      ../../apps/gui

      ../../hosts/${hostname}/config
      ../../hosts/${hostname}/hardware-configuration.nix
      ../../hosts/${hostname}/${hostname}Vars.nix

      inputs.self.nixosModules.default
    ];
  };
in
  mkNixos
