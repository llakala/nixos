{ lib, pkgs, inputs, pkgs-unstable, vars, ...}:

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
      specialArgs =
      {
        inherit inputs pkgs-unstable vars;
        hostVars = import ./${hostName}/${hostName}Vars.nix;
      };
    }
  );

}