{ lib, pkgs, inputs, pkgs-unstable, vars, ...}:

let
  helpers =
  {
    inherit inputs pkgs-unstable vars;
  };

in
{
  generateNix = system: hosts:
  lib.genAttrs hosts
  (
    hostName:
    lib.nixosSystem
    {
      inherit system;

      modules =
      [
        ./baseNix/core
        ./baseNix/features
        ./baseNix/os
        ./baseNix/software
        ./packages/nixPackages.nix
        ./${hostName}/nix
        ./${hostName}/nixware
        {
          nixpkgs.pkgs = pkgs;
        }
      ];

      specialArgs = helpers //
      {
        hostVars = import ./${hostName}/${hostName}Vars.nix;
      };
    }
  );

}