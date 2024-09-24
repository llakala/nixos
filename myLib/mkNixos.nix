{ lib, myLib, inputs, ... }:

let
  internals = # Helper functions we don't plan on exporting past this file
  {
    myPkgs = system: import inputs.nixpkgs { inherit system; config.allowUnfree = true; };
    myUnstablePkgs = system: import inputs.nixpkgs-unstable { inherit system; config.allowUnfree = true; };
  };


  mkNixos = hostname: { system }: # Function to be exported
  lib.nixosSystem
    {
      inherit system;

    specialArgs =
    {
      inherit inputs myLib;

      pkgs-unstable = internals.myUnstablePkgs system;

      vars = import ../base/baseVars.nix;
      hostVars = import ../hosts/${hostname}/${hostname}Vars.nix;
    };

    modules = myLib.importUtils.importAll
    [
      ../base/core
      ../base/features
      ../base/gnome
      ../base/modules
      ../base/terminal

      ../apps/cli
      ../apps/gui

      ../hosts/${hostname}/modules
      ../hosts/${hostname}/hardware-configuration.nix
    ]
    ++
    [
      {
        nixpkgs.pkgs = internals.myPkgs system;
      }
    ];
  };
in
  mkNixos