{ lib, pkgs, inputs, pkgs-unstable, vars, ...}:

{
  mkHosts = system: hosts:
  lib.genAttrs hosts
  (
    hostName:
    lib.nixosSystem
    {
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
          nixpkgs.hostPlatform = system;
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